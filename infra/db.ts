// Copyright 2016-2018, Pulumi Corporation.  All rights reserved.

import * as gcp from "@pulumi/gcp";
import * as config from "./config";

// Provision a database for our Rails app.
export const instance = new gcp.sql.DatabaseInstance("web-db", {
    databaseVersion: "MYSQL_5_7",
    settings: {
        tier: "db-f1-micro",
        ipConfiguration: {
            ipv4Enabled: true,
            authorizedNetworks: [{ value: "0.0.0.0/0" }],
        },
    },
});

// Create a user with the configured credentials for the Rails app to use.
const user = new gcp.sql.User("web-db-user", {
    instance: instance.name,
    name: config.dbUsername,
    password: config.dbPassword,
});
