{{/* 
Merge the local chart values and the library chart defaults.
*/}}
{{- define "library.values.setup" -}}
  {{- if .Values.library -}}
    {{- $defaultValues := deepCopy .Values.library -}}
    {{- $userValues := deepCopy (omit .Values "library") -}}
    {{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
    {{- $_ := set . "Values" (deepCopy $mergedValues) -}}
  {{- end }}  
{{- end }}
