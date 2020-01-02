# Alert Operator Chart

This repository provide a k8s alert-operator chart.

## TL;DR
To install:
```bash
helm upgrade --install -n alert-operator .
```

## Chart Content
The chart will provide the following resources:
1. Alert Operator CRD's resource (installed first using helm CRD hook)
2. Alert operator supporting service-account, cluster-role and cluster-role-binding resources.
3. Alert-operator deployment
4. Alert-operator service,  ServiceMonitor & monitoring resources. *** currently disabled by default as prometheus metrics are not yet supported ***

## alert-operator Configuration
The following values are set in this chart values.yaml, some overwrite the sub-chart values


### k8s-kube2iam Chart Configuration

| Parameter     | Description | Default  |
| ------------- | ------------- | --------|
| replicaCount  | The deployment replace count | 1 |
| image.repository  | The container image repository | georgedriver/alertroute-operator  |
| nameOverride   |  A name to overide chart name. | ''  |
| fullnameOverride   | A full name to be used with chart resources  | ''  |
| service.port   |  The port to expose for metrics |  60000 |
|  monitoring.enabled  | Enable monitoring resources  |  false |
|  monitoring.alerting.enables  | Enable alerting resources  |  false |
| resources   | Resource limit/request for deployment  | {}  |
| nodeSelector   | Node selector label lists  | {}  |
|tolerations   | tolerations label list  | []  |
| affinity   | affinity label list  |  {} |
| imagePullSecrets   | list of existing pull secret to use with the container  |  [] |
| crd.install   | If set, the helm will add the CRD's (Set to true only on new clusters)  | 'false'  |

## Monitoring

### Service Monitor Resource
When monitoring enabled, a ServiceMonitor will be created to auto-add the alert-operator metrics to Prometheus. Check the Prometheus Operator Service Monitor for details.

## Grafana Dashaboard
When monitoring enabled, Helm will create a config map resources with the label of "grafana-dashboard" to store alert-operator dashboards.
If you want to add a new dashboard, create the dashboard, export it to a JSON file and put it in the "dashboards" folder under the charts.
Grafana will auto-detect any dashboard based on the label, and load it.

## Prometheus Rules
PrometheusRules resource is used to create Prometheus alerts. If alerting enabled, helm will create the resource for Prometheus to auto-detect it.
To create/modify alerts - edit the PrometheusRules resource file in the templates folder and change the spec. See Prometheus documantation for more details on alerts.

## Alert Manager
AlertManager resource will handle spinning a new instance of alertmanager for your application.
Use alert manager resource, and it's Configuration to set how your alerts are being handled - if you want to push them to Pagerduty/email/slack etc.
See Prometheus Alert Manager documantation for more details
