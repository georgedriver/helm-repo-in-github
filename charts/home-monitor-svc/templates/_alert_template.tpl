{{- define "alertRuleTemplate.replacePlaceHolders" }}
{{- .text | replace "<APPNAME>" .appName | replace "<JOBNAME>" .appName  | replace "<geEnv>" .geEnv | replace "<DEPLOYSHA>" .deploySHA | replace "<RELEASEVERSION>" .releaseVersion | replace "<NAMESPACE>" .Release.Namespace | replace "<RELEASENAME>" .Release.Name | replace "<RELEASEREVISION>" (toString .Release.Revision ) | replace "<CHARTNAME>" .Chart.Name | replace "<CHARTVERSION>" .Chart.Version }}
{{- end }}

{{- define "alertRuleTemplate.alertTemplate" }}
- alert: {{ .alert.name }}
  annotations:
    description: {{ include "alertRuleTemplate.replacePlaceHolders" (dict "text" .alert.description "appName" .appName "geEnv" .geEnv "deploySHA" .deploySHA "releaseVersion" .releaseVersion "Release" .Release "Chart" .Chart ) }}
    summary: {{ .alert.summary | quote }}
    {{- if .alert.runbook_url }}
    runbook_url: {{ .alert.runbook_url }}
    {{- end }}
  expr: {{ include "alertRuleTemplate.replacePlaceHolders" (dict "text" .alert.expr "appName" .appName "geEnv" .geEnv "deploySHA" .deploySHA "releaseVersion" .releaseVersion "Release" .Release "Chart" .Chart ) }}
  for: {{ .alert.timeToFire }}
  labels:
    alert_source: {{ .appName }}
    app: {{ .appName }}
    namespace: {{ .Release.Namespace }}
    severity: {{ default "warning" .alert.severity }}
    release: {{ .Release.Name }}
    {{- if  .releaseVersion }}
    releaseVersion: {{ .releaseVersion }}
    {{- end }}
    {{- if .deploySHA }}
    deploySHA: {{ .deploySHA }}
    {{- end }}
    {{- if .geEnv }}
    geEnv: {{ .geEnv }}
    {{- end }}
    {{- if .alert.labels -}}
    {{ .alert.labels | toYaml | nindent 6 }}
    {{- end -}}
{{- end }}
