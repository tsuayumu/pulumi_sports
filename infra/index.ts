// Copyright 2016-2018, Pulumi Corporation.  All rights reserved.

import * as docker from "@pulumi/docker";
import * as k8s from "@pulumi/kubernetes";
import * as pulumi from "@pulumi/pulumi";
import * as cluster from "./cluster";
import * as config from "./config";
import * as db from "./db";

// Get the GCR repository for our app container, and build and publish the app image.
const appImageBackend = new docker.Image("rails-app", {
    imageName: `${config.dockerUsername}/${pulumi.getProject()}_${pulumi.getStack()}_backend`,
    build: "../backend",
    registry: {
        server: "docker.io",
        username: config.dockerUsername,
        password: config.dockerPassword,
    },
});

const appImageFrontend = new docker.Image("nuxt-app", {
    imageName: `${config.dockerUsername}/${pulumi.getProject()}_${pulumi.getStack()}_frontend`,
    build: "../frontend",
    registry: {
        server: "docker.io",
        username: config.dockerUsername,
        password: config.dockerPassword,
    },
});

const appImageWeb = new docker.Image("web", {
    imageName: `${config.dockerUsername}/${pulumi.getProject()}_${pulumi.getStack()}_web`,
    build: "../web",
    registry: {
        server: "docker.io",
        username: config.dockerUsername,
        password: config.dockerPassword,
    },
});

// Deploy the app container as a Kubernetes load balanced service.
const appBackendPort = 3001;
const appFrontendPort = 3000;
const appWebPort = 80;
const appLabels = { app: "rails-app" };
const appDeployment = new k8s.apps.v1.Deployment("rails-deployment", {
    spec: {
        selector: { matchLabels: appLabels },
        replicas: 1,
        template: {
            metadata: { labels: appLabels },
            spec: {
                containers: [
                    {
                        name: "rails-app",
                        image: appImageBackend.imageName,
                        env: [
                            { name: "DB_HOST", value: db.instance.firstIpAddress },
                            { name: "DB_USERNAME", value: config.dbUsername },
                            { name: "DB_PASSWORD", value: config.dbPassword },
                            { name: "SECRET_KEY_BASE", value: config.secretKeyBase },
                            { name: "RAILS_ENV", value: "production" },
                            { name: "TWITTER_CONSUMER_SECRET", value: config.twitterConsumerSecret },
                            { name: "TWITTER_ACCESS_TOKEN_SECRET", value: config.twitterAccessTokenSecret }
                        ],
                        ports: [{ containerPort: appBackendPort }],
                    },
                    {
                        name: "nuxt-app",
                        image: appImageFrontend.imageName,
                        ports: [{ containerPort: appFrontendPort }]
                    },
                    {
                        name: "web",
                        image: appImageWeb.imageName,
                        ports: [{ containerPort: appWebPort }]
                    }
                ],
            },
        },
    },
}, { provider: cluster.provider });
const appService = new k8s.core.v1.Service("rails-service", {
    metadata: { labels: appDeployment.metadata.labels },
    spec: {
        type: "LoadBalancer",
        ports: [{ port: appWebPort, targetPort: appWebPort }],
        selector: appDeployment.spec.template.metadata.labels,
    },
}, { provider: cluster.provider });

// Export the app deployment name so we can easily access it.
export let appName = appDeployment.metadata.name;

// Export the service's IP address.
export let appAddress = appService.status.apply(s => `http://${s.loadBalancer.ingress[0].ip}:${appWebPort}`);

// Export the database address for client connections.
export let dbAddress = db.instance.firstIpAddress;

// Also export the Kubeconfig so that clients can easily access our cluster.
export let kubeConfig = cluster.config;
