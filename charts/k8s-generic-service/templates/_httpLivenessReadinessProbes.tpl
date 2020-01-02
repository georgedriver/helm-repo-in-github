{{- define "k8s-generic-service.Helper.HTTPLivenessReadinessProbes" }}
readinessProbe:
  httpGet:
    path: {{ .readiness.path | default .http.path }}
    port: {{ .port }}
  initialDelaySeconds: {{ .readiness.initialDelaySeconds }}
  periodSeconds: {{ .readiness.periodSeconds }}
  failureThreshold: {{ .readiness.failureThreshold }}
  successThreshold: {{ .readiness.successThreshold }}
  timeoutSeconds: {{ .readiness.timeoutSeconds }}
livenessProbe:
  httpGet:
    path: {{ .liveness.path | default .http.path }}
    port: {{ .port }}
  initialDelaySeconds: {{ .liveness.initialDelaySeconds }}
  periodSeconds: {{ .liveness.periodSeconds }}
  failureThreshold: {{ .liveness.failureThreshold }}
  successThreshold: {{ .liveness.successThreshold }}
  timeoutSeconds: {{ .liveness.timeoutSeconds }}
{{- end }}
{{- define "k8s-generic-service.Helper.AdapterHTTPLivenessProbe" }}
livenessProbe:
  httpGet:
    path: {{ .http.adapter.liveness.path }}
    port: {{ .port }}
  initialDelaySeconds: {{ .liveness.initialDelaySeconds }}
  periodSeconds: {{ .liveness.periodSeconds }}
  failureThreshold: {{ .liveness.failureThreshold }}
  successThreshold: {{ .liveness.successThreshold }}
  timeoutSeconds: {{ .liveness.timeoutSeconds }}
{{- end }}
