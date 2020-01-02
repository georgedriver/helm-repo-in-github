# K8s alert receiver

This chart provides a CR for alertmanager recevier (using alert-operator) on k8s.

## TL;DR
To install:
```bash
helm upgrade --install ./k8s-alert-receiver
```

## Chart Content
The chart will create a CR with 2 receivers (based on the provided values):
1. Slack receiver (if slace webhook_url was provided).
2. pagerduty receiver (if pagerduty service_key was provided)

## k8s-alert-receiver Configuration
The following values are set in this chart values.yaml, some overwrite the sub-chart values

### k8s-alert-receiver Chart Configuration

| Parameter     | Description | Default  |
| ------------- | ------------- | --------|
| target_configuration.name  | The  secret name that holds the alertmanager configuration | alertmanager  |
| target_configuration.namespace  | The  namespace that holds the alertmanager secret | system-monitoring  |
|slack.name   | The slack recevier name to create  | "slack_**RELEASE-NAME**"  |
|slack.channel   | The channel to use for alerts  |  "" |
|slack.webhook_url   | The incoming webhook to use with the receiver. leave empty to disable slack receiver  | ""  |
|pagerduty.name   | The pagerduty recevier name to create   |  "pagerduty_**RELEASE-NAME**" |
|pagerduty.service_key   | The pagerduty service key to use with the receiver. Leave empty to disable pagerduty receiver  |  "" |

