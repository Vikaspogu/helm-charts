{{/*
The ServiceAccount object to be created.
*/}}
{{- define "library.serviceAccount" -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "library.names.serviceAccountName" . }}
  labels:
    {{- include "library.labels" . | nindent 4 }}
  {{- with .Values.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}