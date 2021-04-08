{{/*
Renders the Ingress objects required by the chart by returning a concatinated list
of the main Ingress and any additionalIngresses.
*/}}
{{- define "library.ingress" -}}
{{- $ingressName := include "library.names.fullname" . -}}
{{- $values := .Values.ingress -}}
{{- $svcName := $values.serviceName | default (include "library.names.fullname" .) -}}
{{- $svcPort := $values.servicePort | default $.Values.service.port -}}
apiVersion: {{ include "library.capabilities.ingress.apiVersion" .}}
kind: Ingress
metadata:
  name: {{ $ingressName }}
  labels:
    {{- include "library.labels" . | nindent 4 }}
  {{- with $values.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if $values.tls }}
  tls:
    {{- range $values.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
  rules:
    {{- range $values.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            backend:
              serviceName: {{ $svcName }}
              servicePort: {{ $svcPort }}
          {{- end }}
    {{- end }}
{{- end }}