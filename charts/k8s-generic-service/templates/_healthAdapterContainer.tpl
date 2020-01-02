{{- define "k8s-generic-service.Helper.HealthAdapterContainer" }}
- name: {{ .Values.healthProbe.http.adapter.name }}
  image: "{{ .Values.healthProbe.http.adapter.image.repository }}:{{ .Values.healthProbe.http.adapter.image.tag }}"
  imagePullPolicy: {{ .Values.healthProbe.http.adapter.image.pullPolicy }}
  env:
    {{- range .Values.healthProbe.http.adapter.envVars }}
    - name: {{ .name }}
      value: {{ .value }}
    {{- end }}
  {{ include "k8s-generic-service.Helper.AdapterHTTPLivenessProbe" .Values.healthProbe | indent 2 }}
  resources:
{{ toYaml .Values.healthProbe.http.adapter.resources | indent 4 }}
{{- end }}
