{{/*
Volumes included by the controller.
*/}}
{{- define "library.volumes" -}}
{{- range $index, $persistence := .Values.persistence }}
{{- if $persistence.enabled }}
- name: {{ $index }}
{{- if $persistence.existingClaim }}
{{- /* Always prefer an existingClaim if that is set */}}
  persistentVolumeClaim:
    claimName: {{ $persistence.existingClaim }}
{{- else -}}
  {{- /* Always prefer an emptyDir next if that is set */}}
  {{- $emptyDir := false -}}
  {{- if $persistence.emptyDir -}}
    {{- if $persistence.emptyDir.enabled -}}
      {{- $emptyDir = true -}}
    {{- end -}}
  {{- end -}}
  {{- if $emptyDir }}
  {{- if or $persistence.emptyDir.medium $persistence.emptyDir.sizeLimit }}
  emptyDir:
    {{- with $persistence.emptyDir.medium }}
    medium: "{{ . }}"
    {{- end }}
    {{- with $persistence.emptyDir.sizeLimit }}
    sizeLimit: "{{ . }}"
    {{- end }}
  {{- else }}
  emptyDir: {}
  {{- end }}
  {{- else -}}
  {{- /* Otherwise refer to the PVC name */}}
  {{- $pvcName := (include "library.names.fullname" $) -}}
  {{- if $persistence.nameSuffix -}}
    {{- if not (eq $persistence.nameSuffix "-") -}}
      {{- $pvcName = (printf "%s-%s" (include "library.names.fullname" $) $persistence.nameSuffix) -}}
    {{- end -}}
  {{- else -}}
    {{- $pvcName = (printf "%s-%s" (include "library.names.fullname" $) $index) -}}
  {{- end }}
  persistentVolumeClaim:
    claimName: {{ $pvcName }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- if .Values.additionalVolumes }}
  {{- toYaml .Values.additionalVolumes | nindent 0 }}
{{- end }}
{{- end -}}
