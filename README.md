## setup

pulumi setup

```bash
pulumi stack init sports-rails
pulumi config set gcp:project test-25245-264913
pulumi config set gcp:zone us-west1-a
pulumi config set clusterPassword --secret 8EKdh59IQs38cNiJ
pulumi config set dbUsername #{db_user}
pulumi config set dbPassword --secret #{db_password}
pulumi config set dockerUsername #{dockerhub_username}
pulumi config set dockerPassword --secret #{dockerhub_password}
pulumi config set secretKeyBase --secret #{secret_key}
pulumi config set masterVersion
pulumi up
```

kubectl setup

```bash
gcloud container clusters list
gcloud container clusters get-credentials #{cluster_name} --project #{project} --zone=#{zone}
```

pulumi detele

```bash
pulumi destroy
pulumi stack rm sports-rails
```