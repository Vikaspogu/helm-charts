{{/*
Renders the Service objects required by the chart by returning a concatinated list
of the main Service and any additionalServices.
*/}}
{{- define "library.service" -}}
{{- $svcName := include "library.names.fullname" . -}}
{{- $values := .Values.service -}}
{{- $svcType := $values.type | default "" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ $svcName }}
  labels:
    {{- include "library.labels" . | nindent 4 }}
  {{- if $values.labels }}
    {{ toYaml $values.labels | nindent 4 }}
  {{- end }}
  {{- with $values.annotations }}
  annotations:
    {{ toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if (or (eq $svcType "ClusterIP") (empty $svcType)) }}
  type: ClusterIP
  {{- if $values.clusterIP }}
  clusterIP: {{ $values.clusterIP }}
  {{end}}
  {{- else if eq $svcType "LoadBalancer" }}
  type: {{ $svcType }}
  {{- if $values.loadBalancerIP }}
  loadBalancerIP: {{ $values.loadBalancerIP }}
  {{- end }}
  {{- if $values.externalTrafficPolicy }}
  externalTrafficPolicy: {{ $values.externalTrafficPolicy }}
  {{- end }}
  {{- if $values.loadBalancerSourceRanges }}
  loadBalancerSourceRanges:
    {{ toYaml $values.loadBalancerSourceRanges | nindent 4 }}
  {{- end -}}
  {{- else }}
  type: {{ $svcType }}
  {{- end }}
  ports:
    - port: {{ $values.port }}
      targetPort: {{ $values.targetPort | default .name | default "http" }}
      protocol: {{ $values.protocol | default "TCP" }}
      name: {{ $values.name | default "http" }}
      {{- if (and (eq $svcType "NodePort") (not (empty $values.nodePort))) }}
      nodePort: {{ $values.nodePort }}
      {{ end }}
  selector:
    {{- include "library.labels.selectorLabels" . | nindent 4 }}
{{- end -}}