{{/*
Library labels shared across objects.
*/}}
{{- define "library.labels" -}}
helm.sh/chart: {{ include "library.names.chart" . }}
{{ include "library.labels.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels shared across objects.
*/}}
{{- define "library.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "library.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}