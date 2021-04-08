{{/*
This template serves as the blueprint for the Deployment objects that are created 
within the library library.
*/}}
{{- define "library.deployment" -}}
apiVersion: {{ include "library.capabilities.deployment.apiVersion" . }}
kind: Deployment
metadata:
  name: {{ include "library.names.fullname" . }}
  labels:
    {{- include "library.labels" . | nindent 4 }}
    {{- with .Values.labels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- with .Values.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  replicas: {{ .Values.replicas }}
  {{- with .Values.strategy }}
  strategy:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  selector:
    matchLabels:
    {{- include "library.labels.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
      {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
      {{- include "library.labels.selectorLabels" . | nindent 8 }}
    spec:
      {{- include "library.pod" . | nindent 6 }}
{{- end }}
