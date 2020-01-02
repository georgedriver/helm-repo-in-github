# k8s Prometheus Operator

This repository intend to provide a Prometheus Operator and kube-prometheus based on the prometheus-operator official helm chart

## TL;DR
To install:
```bash
helm dep build
helm upgrade --install ./k8s-prometheus-operator
```

## Chart Content
The chart will provide the following resources via dependencies:
1. [Prometheus Operator Chart](https://github.com/coreos/prometheus-operator)
3. [Kube-prometheus chart](https://github.com/coreos/prometheus-operator) and sub-charts
  1. prometheus-server & prometheus instances
  2. kube-state-metrics & exporter-kube-state
  3. node-expoerter & exporter-node
  4. alertmanager
  5. grafana (Disabled by default, as we provide k8s-grafana)
  6. Alerting rules for different cluster resources
  7. Alertmanager Route for specific alerts
  8. a Datasource ConfigMap for Prometheus, to be used by Grafana to autoload the datasource

## k8s-prometheus-operator Configuration
The following values are set in this chart values.yaml, some overwrite the sub-chart values

### Dependencies Custom Values
It is possible to pass a custom setting to a sub-chart from the dependencies. Check each sub-chart documantation for more info on values.
To pass a value down to a sub chart, use the sub-chart name or it's alias (check the requriments file) as key.
For example to pass a value to grafana sub-chart, from a custom values file:
```yaml
grafana:
  replicaCount: 4
```
You can do the same via argument to the helm install/upgrade command:
```--set grafana.replicaCount=4```

### [k8s-prometheus-operator] Chart

| Parameter     | Description | Default  |
| ------------- | ------------- |--------|
|global_recievers.slack.name   | The default alertmanager slack recevier name  |  "k8s_slack_alerts" |
|global_recievers.slack.url   | The slack integration webhook  url | https://hooks.slack.com/services/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  |
|global_recievers.slack.channel  | The slack channel to use | '#k8s_alerts'  |
|global_recievers.pagerduty.name   | The default alertmanager pager duty recevier name |  "k8s_pg_alerts" |
|global_recievers.pagerduty.integration_key   | The pager duty integration key | "" |
|cluster_name   | Cluster name to append to alerts on slack notifications  |  k8s  |
|monitoring.enabled | Set to true to enable monitoring | true  |
|monitoring.alerting.enabled  | Set to true to enable alerting routes and receiver creation | false  |
| prometheus_cluster.enabled | Set to true to create prometheus instance to scrape based on service discovery and hashmod  | "false"  |
| prometheus_cluster.workers | Set the number of prometheus workers (instances) for prometheus cluster | 2 |

### [prometheus-operator] Charts and It's sub-charts
Visit the [official stable prometheus-operator chart](https://github.com/helm/charts/tree/master/stable/prometheus-operator) for a full list of all onfiguration values.
