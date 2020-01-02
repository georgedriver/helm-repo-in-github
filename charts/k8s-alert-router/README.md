# k8s alert router

This chart provides a CR for alertmanager router on k8s. The CR will route all alerts to the warningReceiverName, and all critical alerts to the criticalReceiverName.

## TL;DR
Include this chart with other projects as a Requirement and set your k8s-alert-router values (described below) in order to target your alert-receiver

## How to use this chart
The alert router chart is ment to be used as a sub-chart, within your application.
To use it, first make sure all your prometheus rules contains the following labels:

| label     | value |
| ------------- | ------------- |
| severity  | The severity for your alert (lowercase). I.e critical, warning, info  |
| namespace | The namespace of where your application lives. You can use {{ .Release.Namespace }} to templatize it  |
| alert_source | The release name of your installed chart. You can use {{ .Release.Name }} to templatize it   |

You will also need to tell the chart (using the values below) where is the alertmanager configuration to update. In k8s clusters it's going to under the "system-monitoring" namesapce and "alertmanager-k8s-prometheus-operator" (see example below on how to add it)

### Adding the k8s-alert-route to your chart:
In your chart create a requirements.yaml file and add the following (be sure the change the version to the latest):
```YAML
dependencies:
  - name: k8s-alert-router
    version: 0.1.8
    repository: https://raw.githubusercontent.com/georgedriver/helm-repo-in-github/master
    condition: monitoring.alerting.enabled
```

Now add the values of where's the alert manager configuration is (use the values here for k8s clusters), the your Vaules.yaml file:
```YAML
k8s-alert-router:
  selectors:
    secretName: alertmanager-k8s-prometheus-operator
    alertManagerNamespace: system-monitoring
```


You can then enable/disable it by adding this to your Values.yaml file:
```YAML
monitoring:
    alerting:
      enabled: true
```

## k8s-alert-router Configuration
The following values are set in this chart values.yaml, some overwrite the sub-chart values

### k8s-alert-receiver Chart Configuration

| Parameter     | Description | Default  |
| ------------- | ------------- | --------|
| selectors.secretName  | The  secret name that holds the alertmanager configuration | my-secret-name  |
| selectors.alertManagerNamespace  | The  namespace that holds the alertmanager secret | my-alert-manager-namespace |
|receivers.warningReceiverName   | The recevier to use for warning alerts  | my-warning-receiver-name |
|receivers.criticalReceiverName   | The receiver to use for critical alerts  |  my-critical-receiver-name |
|metadata.alertManagerRouteName   | The name you want to give your alertmanager route  | my-alert-manager-route-name  |
