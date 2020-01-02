# k8s Grafana

This chart intend to provide grafana as a visualtion for Prometheus datasource.

## TL;DR
To install:
```bash
helm dep build
helm upgrade --install ./k8s-grafana
```


## Chart Content
The chart will provide the following resources:
1. Set of dashboards (as config maps resources) for Grafana.
2. A Grafana datasource setting (as config map resource) for Prometheus that is set using this chart.
3. Auth configuration for Grafana (as Secret resource). See documantation [here](http://docs.grafana.org/auth/github/)

## Dependencies
The k8s-garafana helm chart here is depended on the following helm charts (and their depeneds):
1.  [stable/grafana](https://github.com/helm/charts/tree/master/stable/grafana)

## k8s Grafana Dashboards
The stable/grafana deployment will auto-discover & update dashboards that are loaded to the cluster as ConfigMap resources. The dashboard ConfigMap must include the label "grafana-dashboard" (as a label name, value does not matter), or any costume label name that is defined in the grafana.dashboard.label.
** It is recommanded to have one dashboard per ConfigMap **

## k8s Grafana Datasources
The stable/grafana deployment will auto-discover & update Datasources that are loaded to the cluster as ConfigMap resources. The datasource ConfigMap must include the label "grafana-datasource" (as a label name, value does not matter), or any costume label name that is defined in the grafana.datasource.label

## k8s-grafana Configuration
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

### k8s-grafana & [Grafana](https://github.com/helm/charts/tree/master/stable/grafana) Chart configuration
This configuration applies to the k8s monitoring and stable/grafana sub-chart

| Parameter     | Description | Affected Charts | Default  |
| ------------- | ------------- | -----|--------|
|auth.root_url   | Set the root URL for Grafana auth, when using Proxy | we8s-grafana | ''  |
|auth.github.enable   | Set to true to enable Github auth with Grafana  | we8s-grafana | False  |
| auth.github.client_id  | The oauth client id for Grafana Github auth  | k8s-grafana  |  '' |
| auth.github.client_secret  | The oauth client secret for Grafana Github auth  | k8s-grafana  | ''  |
|auth.github.organizations   | Github organizations list (comma seperated) that are allowed to access Grafana (i.e the user authenticating needs to be a memeber of these organizations) | k8s-grafana  | goatapp  |
|auth.github.teamsID   | Github team id list (comma seperated) that are allowed to access Grafana (i.e the user authenticating needs to be a memeber of these team)  | k8s-grafana  | ''  |
|auth.okta.enabled   | Enable Okta SSO  | k8s-grafana  | false  |
|auth.okta.client_id   | Set Okta client ID  |  k8s-grafana | ''  |
|auth.okta.client_secret   | Set Okta client Secret  |  k8s-grafana | ''  |
|datasource.hostname   | The hostname of the prometheus service running in the cluster  | k8s-prometheus  | k8s-grafana  |
|datasource.port  | The port of the prometheus service running in the cluster  | k8s-grafana  | 9090  |
| hpa.enabled   | Enable / Disable pod auto scaling  | k8s-grafana  | 'true'  |
| hpa.replicas.min   | minimum number of replicas to scale in to  | k8s-grafana  | 1  |
| hpa.replicas.max  | maximum number of replicas to scale out to  | k8s-grafana  | 5  |
| hpa.cpuUtilization   | AVG CPU utilization value for scaling  | k8s-grafana  | 85%  |
| memoryUtilization   | Target memory value for scaling (leave empty to disable) | k8s-grafana  |  '' |
|grafana.ingress.enabled   | Enable/Disable Ingress resource  |  stable/grafana |  true |
|grafana.ingress.annotations    | List of annotation to add to Ingress  |  stable/grafana | kubernetes.io/ingress.class: nginx-external  |
|grafana.ingress.hosts   | List of hosts names for Ingress. Will be set as DNS records  | stable/grafana  |  grafana.alpha.k8s.com |
|grafana.envFromSecret   | A name of secret resource to load as enviorment vars to Grafana pods. Required for Github auth  | stable/grafana  |  grafana-github-auth |
|sidecar.dashboards.enabled   | Enable side car to auto-load new dashboards (see more info below)  |  stable/grafana |  true |
|grafana.sidecar.dashboards.label   | Set a label name for auto-discovery of dashboards config maps (see more info below)  | stable/grafana  |  grafana-dashboard |
|grafana.sidecar.datasource.enabled   | Enable side car to auto-load new datasources (see more info below)  | stable/grafana  |  true |
|grafana.sidecar.datasource.label   | Set a label name for auto-discovery of datasources config maps (see more info below)   |  stable/grafana |  grafana-datasource |
|monitoring.alerting.enabled   | Enable to create Prometheus alerts for Grafana (PrometheusRule resource)  | k8s-grafana  | true  |
