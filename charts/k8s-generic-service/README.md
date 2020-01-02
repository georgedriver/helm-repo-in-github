# Generic Service Chart

[Getting Involved](#get-involved)

[What is a Generic Service](#what-is-a-generic-service)

  - [Optional Features](#optional-features)

[Migrating to newer Chart Versions](#migrating-to-newer-chart-versions)

[Configuring with values.yml](#configuration)

[Example values.yaml](#example-valuesyaml)

[Using with Helmfile](#using-with-helmfile)

[GRPC/JSON Transcoder](#grpc<->json-transcoder)

[Migrating to a newer version](./migrations/migrations.md)

---

## Get Involved

- **Contributing**: Pull requests are welcome!

### What is a Generic Service?

A potential Generic Service will be a Deployment requiring the following Kubernetes objects:
- Deployment
  - with Vault integration (optional) ([vault wrapper](https://github.com/georgedriver/k8s-vault-init/blob/feature/adds_readme/README.md) + auto inject annotation)
- Pods
- HTTP Service

#### Optional features
- Volumes
- Ingress
- HTTP Service with Basic Auth
- GRPC Service
- Monitoring
- Dashboards
- DB Migrations for projects using [FlywayDB](https://flywaydb.org/)
- [gRPC Health Adapter](https://github.com/georgedriver/grpc-health-adapter)

## Migrating to Newer Chart Versions

This documentation has been factored out into their own README files.
[Please view the documentation on how to migrate from version to version.](./migrations/migrations.md)

## Configuration

Parameter | Description | Default
--- | --- | ---
`appName` | name of the application | `ZaService`
`releaseVersion` | label that will be visible in helm | `not-specified`
`envVars` | List of environment variables inherited in all Pods  | `[]`
`geEnv` | Environment name label. Only if you need it in your service | `dev`
`deploySHA`| Git Commit SHA1 of the current deploy. Only if you need it in your service | `xxxxxxx`
`command` | The command needs to be explicit even if already defined in your Dockerfile | ``
`args` | List of args for the command | `[]`
`replicaCount` | Number of required pods | `1`
`healthPath` | Liveness and readiness health check path | `/health`
`healthPort` | TCP health check. Only used if defined and `healthPath` set to false | ``
`resources` | [Compute Resources](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) | |
--- | --- | ---
`image.repository` | Docker image path | `nginx`
`image.tag` | Docker image tag | `latest`
`image.pullPolicy` | When it should checked for pulling the image | `IfNotPresent`
--- | --- | ---
`service.ports`| List of ports which application listen to. Each item of the list must have `port`(e.g. 80), `containerPort`(e.g. 3000), `name`(e.g. http), `protocol`(e.g. TCP)|[]
--- | --- | ---
`ingress.enabled` | | `false`
`ingress.grpc` | Denotes whether to use the GRPC specific ingress | `false`
`ingress.alicloud` | Denotes whether to use the Alicloud Ingress Controller specific ingress | `false`
`ingress.port` | The port number of the application | 80
`ingress.annotations` | | `{}`
`ingress.path` | | `/`
`ingress.hosts` | | `[chart-example.local]`
`ingress.tls` | | `[]`
`ingress.basicAuth.enabled` | | `false`
`ingress.basicAuth.secretName` | See [here](https://github.com/kubernetes/ingress-nginx/blob/master/docs/examples/auth/basic/README.md) | `myAuthSecret`
`ingress.server_snippets` | List of strings that will be added to the ingress nginx server snippets. Doc [here](https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/nginx-configuration/annotations.md#server-snippet) | `[]`
--- | --- | ---
`monitoring.enabled` | See [here](https://connect.we.co/display/TDP/Monitoring) | `false`
`monitoring.team` | | `ZaService`
`monitoring.servicePortName` | The port name where service exposing prometheus end-point| http
`monitoring.servicePath` | The path is exposing prometheus end-point| '/metrics'
`alerts.enableDefaultAlerts`  | Enable a default set of alerts for your service (see alerts section below) | `false`
`alerts.extraAlerts`  | A list of custom alert alerts for your service (see alerts section below) | `[]`
--- | --- | ---
`cronjobs` | List of CronJobs associated with the Service | `[]`
`vault.enabled` | Appends required annotation to your pods to enable vault pod injection | `false`
`vault.skipCommand` | Disables command prepending on injection | `false`
`volumes` | | `[]`
--- | --- | ---
`flywayJob.enabled` | Enables migrations for projects that use [FlywayDB](https://flywaydb.org/) | `false`
`flywayJob.name` | The name of the K8 job created | `MigrateFlywayJob`
`flywayJob.databaseType` | The JDBC database type, usually right after `jdbc://<databaseType>`. Can be `postgresql`, `mysql`, `sqlserver` | `mysql`
`flywayJob.sqlImage.repository` | The docker repo where the image is stored | ``
`flywayJob.sqlImage.tag` | The docker image's tag | `latest`
`flywayJob.flywayImage.repository` | The flyway docker repo | `boxfuse/flyway`
`flywayJob.flywayImage.tag` | The flyway docker tag | `latest`
--- | --- | ---
`hpa.enabled`  | Enable horizontal Pod Autoscaler  |  `false`
`hpa.replicas.min`  | Minimum number of pod replicas to scale in |  `1`
`hpa.replicas.max`  | maximum number of replicas to scale out  |  `5`
`hpa.cpuUtilization`  | Average CPU utilization value (use integer as percentge e.g 75 for 75%). Optional - use at least one of the two from cpuUtilization and  memoryUtilization |  `75`
`hpa.memoryUtilization`  | Average memory utilization value (use memory value as a string with unit suffix. I.E 1000Mi). Optional - use at least one of the two from cpuUtilization and  memoryUtilization  | ``
--- | --- | ---
`autorunRestart.enabled`  | Enables Autorun to restart pods belonging to a specific Deployment  |  `false`
`autorunRestart.label`  | Autorun label for a Deployment |  `n/a`
--- | --- | ---
`healthProbe.port` | Default port for HTTP and TCP liveness/readiness checks | `3000`
`healthProbe.http.enabled` | Verify health via HTTP requests | `false`
`healthProbe.tcp.enabled` | Verify health via TCP connection establishment | `false`
`healthProbe.exec.enabled` | Execute command to perform health checks | `false`
`healthProbe.http.adapter.name` | Default container name for the grpc-health-adapter | `grpc-health-adapter`
`healthProbe.http.adapter.enabled` | The health adapter is disabled by default | `false`
`healthProbe.http.adapter.liveness.path` | The default health adapter container liveness path | `/adapter-health`
`healthProbe.http.adapter.image.repository` | Default grpc-health-adapter container image repository | `quay.io/georgedriver/grpc-health-adapter`
`healthProbe.http.adapter.image.tag` | Default grpc-health-adapter image tag | `v0.0.110`
`healthProbe.http.adapter.image.pullPolicy` | When it should checked for pulling the grpc-health-adapter image | `IfNotPresent`
`healthProbe.http.adapter.resources` | [Compute Resources](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) | |
`healthProbe.liveness` | [Liveness Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/) | |
`healthProbe.readiness` | [Readiness Probes](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/) | |
## Example values.yaml

```
# Default values for generic_service.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

appName: k8s-sample
namespace: sample

releaseVersion: 1.0.0

replicaCount: 1

command:
  - bundle
args:
  - exec
  - puma
  - -C
  - config/puma.rb

healthPath: /hello              # set to false if no path available
# healthPort: 3000

progressDeadlineSeconds: 600    # this will set the progress deadline for checking rollout status, make sure to set higher value than minReadySeconds, or chart will fail
minReadySeconds: 0              # this will set the minimum number of seconds for which a newly created Pod should be ready

image:
  repository: quay.io/georgedriver/sample-app
  # tag: latest                 # this will be overwritten by the release process
  pullPolicy: Always

service:
  type: ClusterIP
  ports:
    - port: 3000
      containerPort: 3000
      name: http
      protocol: TCP

ingress:
  enabled: true
  port: 3000
  annotations:
    kubernetes.io/ingress.class: nginx-external
    nginx.org/server-snippet: "proxy_ssl_verify off;"
  path: /

monitoring:
  enabled: true
  servicePortName: http
  team: sample

alerts:
  enableDefaultAlerts: true
  extraAlerts: []

vault:
  enabled: true

runJob:
  # enabled: true                # will be set by the deploy process when necessary
  name: migratejob
  image:
    repository: quay.io/georgedriver/sample-app
    # tag: latest                # will be overwritten during release
  command: ["rake", "db:migrate"]

envVars:
  - Name: MY_USERNAME
    Value: "vault:database/creds/sample-role#username"

  - Name: MY_PASSWORD
    Value: "vault:database/creds/sample-role#password"

  - Name: MY_HOST
    Value: "vault:secret/sample/database-vars#ENDPOINT"

  - Name: MY_DATABASE
    Value: "vault:secret/sample/database-vars#NAME"

  - Name: REDIS_URL
    Value: "sample-app-redis-master"

  - Name: REDIS_PORT
    Value: 6379
```

## Using with Helmfile

```
# helmfile.yaml

repositories:
  - name: stable
    url: https://kubernetes-charts.storage.googleapis.com/
  - name: georgedriver
    url: https://georgedriver.jfrog.io/georgedriver/helm
    username: {{ requiredEnv "ARTIFACTORY_USER" }}
    password: {{ requiredEnv "ARTIFACTORY_APIKEY" }}

helmDefaults:
  tillerNamespace: sample
  args:
    - "--tls"

releases:
  - name: sample-app
    namespace: sample
    chart: georgedriver/k8s-generic-service
    values:
      - "../.deploy/values.yml"
    set:
      - name: image.tag
        value: {{ env "CIRCLE_TAG" | default (env "CIRCLE_SHA1") }}
      - name: ingress.hosts[0]
        value: {{ requiredEnv "INGRESS_HOST" }}
      - name: ingress.tls[0].hosts[0]
        value: {{ requiredEnv "INGRESS_HOST" }}


```

## GRPC<->JSON Transcoder

If you have Istio enabled in your team's namespace you can take advantage of an Envoy filter to transcode requests from a RESTful/JSON to gRPC and back without any code changes to the service itself.

The proto definitions for the service need to be annotated with GOOGLEAPIS options to map between the RPCs and RESTful routes. See [here](https://cloud.google.com/service-infrastructure/docs/service-management/reference/rpc/google.api#http).

Proto-descriptors (the C++ gRPC client format) need to be generated. Ideally this logic will be added to the proton repository in the near future, but for now they can be generated locally via this protoc like so (you will need to clone the googleapis repo if you do not have it already) :

```
 -I $GOOGLEAPIS_DIR -I . \
 --descriptor_set_out={SERVICENAME}.proto-descriptor \
 --include_imports \
 {PATH_TO_PROTO_FILE}
```

Include the generated proto-descriptor somewhere in your repo and include the following in your helm or helmfile values.

Example snippet:
```
grpcTranscoder:
  enabled: true
  port: 7777                                       # port your gRPC service is listening on
  protoServices:                                   # Fully qualified proto service name(s)
    - "we.identity.token_transform.TokenTransform"
  protoDescriptorB64String: {{ readFile "transcoder/tokentransform.proto-descriptor" | b64enc }} # base64 encoded string containing the full proto descriptor
```

# Monitoring Metrics endpoint discovery

When enabled (`monitoing.enabled: true`) , the chart will register your application into Prometheus and will start scraping metrics from your application. In order for it to work, your application needs to expose a metrics endpoint (/metrics) over a specifc port (`monitoing.servicePortName`, default to http).

# Alerts

## Default Alerts
Enabling alerts (`alerts.enableDefaultAlerts: true`) will deploy a set of default service alerts:

Alert name | Summary | Severity
---|---|---
noScrapeTargets  | Send a warning alert if there are no monitoing scrape endpoints discoverd for your app (on /metrics) for 5 minutes- see monitoring   |  warning
noScrapeTargets  | Send a warning alert if there are no monitoing scrape endpoints discoverd for your app (on /metrics)  for 20 minutes- see monitoring  |  Critical

## Extra Alerts
In this section you can add a list for custom alert for your service.

#### Alert Properites
Name | Description | Default
---|---|
name  | Alert name  | `""`
summary  | Short description of the alert  |  `""`
description  | The alert full description (default to summary if empty). You can use placeholder for specific values here (See below) | `""`
expr  | The experession that will trigger the alert (PromQL). You can use placeholder for specific values here (See below) | `""`
timeToFire  | The alert will fire only if the expr matched true for more than this time. |  `"5m"`
severity  | The alert severity  | `"warning"`
runbook_url  | Optional - A URL to a run book on how to resolve the alert  | `""`
labels  | A labels that will be added to your alert in a format of `key: value` (**NOTE** - Some labels will be added by default, see below)  | `{}`

#### Alert Placeholders
You can use the following placehoders in the `description` and `expr` properites. They will be replaced with the coresspanding values:

Placeholder | Value
--|--
`<APPNAME>`  | The appName value defined in the Values file
`<NAMESPACE>` | The namespace the app is deployed too.
`<JOBNAME>` | The Service Monitor scrape job name (default to appName)
`<geEnv>`  |  The geEnv value defined in the Values file
`<DEPLOYSHA>`  |  The deploySHA value defined in the Values file
`<RELEASEVERSION>`  |  The releaseVersion value defined in the Values file
`<RELEASENAME>`  |  The **helm** release name of the app
`<RELEASEREVISION>`  | The **helm** release revision of the app (.Release.Revision)
`<CHARTNAME>`  | The **helm** chart name (.Chart.Name)
`<CHARTVERSION>`  | The **helm** chart version (.Chart.Version)

#### Alert Labels
The folliowing labels will be added by default to your alert:
* alert_source - The app name as set in the values file
* app - The app name as set in the values file
* namespace - The namespace the app is deployed too
* severity - The severity of the alert (Based on the value provided, default to warning)
* release - The **helm** release name of the app
* releaseVersion - The release version (if provided) from the values file
* deploySHA - The deploy SHA (if provided) from the value files
* geEnv - The geEnv as provided from the values file


#### Custume Alert example
```YAML
alerts:
  extraAlerts:
    - name: TestAlert
      summary: This is a test alert that will always fire
      description: This alert is genertated for TEST reasons - it will always fire as  job is always eq or higer then 0 (currently {{ $value }})
      expr: count(up{namespace="<NAMESPACE>",appName="<APPNAME>",release="<RELEASENAME>"}) >= 0
      timeToFire: 5m
      severity: warning
      runbook_url: ""
      labels:
        team: "observability"
```
