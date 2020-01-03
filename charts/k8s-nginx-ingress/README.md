# k8s Nginx

This chart provides custom Nginx ingress for k8s. It uses the [stable/nginx-ingress](https://github.com/helm/charts/tree/master/stable/nginx-ingress), and adds k8s specific resources.

## TL;DR
To install:
```bash
helm dep build
helm upgrade --install ./k8s-nginx
```

## Chart Content

The chart will provide the following resources:

1. dependency: [stable/nginx-ingress](https://github.com/helm/charts/tree/master/stable/nginx-ingress)

## k8s-nginx Configuration
The following values are set in this chart values.yaml.

### k8s-nginx-ingress Chart Configuration

| Parameter | Description | Default  |
| --- | --- | --- |
| ingress.controller.stats | if true, enable "vts-status" page | false |
| ingress.controller.metrics | if true, enable Prometheus metrics (controller.stats.enabled must be true as well) | false |

## Monitoring

### Service Monitor Resource
When monitoring enabled, a ServiceMonitor will be created to auto-add the k8s-nginx-ingress metrics to Prometheus. Check the Prometheus Operator Service Monitor for details.

## Grafana Dashaboard
When monitoring enabled, Helm will create a config map resources with the label of "grafana-dashboard" to store k8s-nginx-ingress dashboards.
If you want to add a new dashboard, create the dashboard, export it to a JSON file and put it in the "dashboards" folder under the charts.
Grafana will auto-detect any dashboard based on the label, and load it.

## Prometheus Rules
PrometheusRules resource is used to create Prometheus alerts. If alerting enabled, helm will create the resource for Prometheus to auto-detect it.
To create/modify alerts - edit the PrometheusRules resource file in the templates folder and change the spec. See Prometheus documentation for more details on alerts.
