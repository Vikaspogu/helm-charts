{{/*
Create the name of the service account to use
*/}}
{{- define "schedule-pod-restart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "library.names.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "schedule-pod-restart.role" -}}
{{- default (include "library.names.fullname" .) .Values.role.name }}
{{- end }}

{{/*
Create the name of the role binding to use
*/}}
{{- define "schedule-pod-restart.roleBinding" -}}
{{- default (include "library.names.fullname" .) .Values.bindings.role.name }}
{{- end }}
