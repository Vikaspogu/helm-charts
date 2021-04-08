{{/*
Main entrypoint for the library library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "library.all" -}}
  {{- /* Merge the local chart values and the library chart defaults */ -}}
  {{- include "library.values.setup" . }}

  {{- /* Build the templates */ -}}
  {{ include "library.pvc" . | nindent 0 }}
  {{- print "---" | nindent 0 -}}
  {{- if .Values.serviceAccount.create -}}
    {{- include "library.serviceAccount" . }}
    {{- print "---" | nindent 0 -}}
  {{- end -}}
  {{- include "library.deployment" . | nindent 0 }}
  {{- print "---" | nindent 0 -}}
  {{ include "library.service" . | nindent 0 }}
  {{- print "---" | nindent 0 -}}
  {{- if .Values.ingress.enabled -}}
    {{- include "library.ingress" . }}
  {{- end -}}
{{- end -}}
