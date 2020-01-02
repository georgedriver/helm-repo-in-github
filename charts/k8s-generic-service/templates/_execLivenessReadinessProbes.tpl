{{- define "k8s-generic-service.Helper.ExecLivenessReadinessProbes" }}
readinessProbe:
  exec:
    command:
    {{- range .readiness.command }}
    - {{ . | quote }}
    {{- end }}
  initialDelaySeconds: {{ .readiness.initialDelaySeconds }}
  periodSeconds: {{ .readiness.periodSeconds }}
  failureThreshold: {{ .readiness.failureThreshold }}
  successThreshold: {{ .readiness.successThreshold }}
  timeoutSeconds: {{ .readiness.timeoutSeconds }}
livenessProbe:
  exec:
    command:
    {{- range .liveness.command }}
    - {{ . | quote }}
    {{- end }}
  initialDelaySeconds: {{ .liveness.initialDelaySeconds }}
  periodSeconds: {{ .liveness.periodSeconds }}
  failureThreshold: {{ .liveness.failureThreshold }}
  successThreshold: {{ .liveness.successThreshold }}
  timeoutSeconds: {{ .liveness.timeoutSeconds }}
{{- end }}
