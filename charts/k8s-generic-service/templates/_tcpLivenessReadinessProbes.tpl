{{- define "k8s-generic-service.Helper.TCPLivenessReadinessProbes" }}
readinessProbe:
  tcpSocket:
    port: {{ .port }}
  initialDelaySeconds: {{ .readiness.initialDelaySeconds }}
  periodSeconds: {{ .readiness.periodSeconds }}
  failureThreshold: {{ .readiness.failureThreshold }}
  successThreshold: {{ .readiness.successThreshold }}
  timeoutSeconds: {{ .readiness.timeoutSeconds }}
livenessProbe:
  tcpSocket:
    port: {{ .port }}
  initialDelaySeconds: {{ .liveness.initialDelaySeconds }}
  periodSeconds: {{ .liveness.periodSeconds }}
  failureThreshold: {{ .liveness.failureThreshold }}
  successThreshold: {{ .liveness.successThreshold }}
  timeoutSeconds: {{ .liveness.timeoutSeconds }}
{{- end }}
