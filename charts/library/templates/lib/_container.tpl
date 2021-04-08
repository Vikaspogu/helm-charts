{{- /*
The main container included in the controller.
*/ -}}
{{- define "library.mainContainer" -}}
{{- $svc := .Values.service -}}
{{- $svcPort := .Values.service.name -}}
- name: {{ include "library.names.fullname" . }}
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- with .Values.command }}
  {{- if kindIs "string" . }}
  command: {{ . }}
  {{- else }}
  command: 
  {{ toYaml . | nindent 2 }}
  {{- end }}
  {{- end }}
  {{- with .Values.args }}
  {{- if kindIs "string" . }}
  args: {{ . }}
  {{- else }}
  args: 
  {{ toYaml . | nindent 2 }}
  {{- end }}
  {{- end }}
  {{- with .Values.securityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.lifecycle }}
  lifecycle:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- if or .Values.env .Values.envTpl .Values.envValueFrom }}
  env:
  {{- range $key, $value := .Values.env }}
  - name: {{ $key }}
    value: {{ $value | quote }}
  {{- end }}
  {{- range $key, $value := .Values.envTpl }}
  - name: {{ $key }}
    value: {{ tpl $value $ | quote }}
  {{- end }}
  {{- range $key, $value := .Values.envValueFrom }}
  - name: {{ $key }}
    valueFrom:
      {{- $value | toYaml | nindent 6 }}
  {{- end }}
  {{- end }}
  {{- if or .Values.envFrom .Values.secret }}
  envFrom:
  {{- with .Values.envFrom }}
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- if or .Values.secret }}
  - secretRef:
      name: {{ include "library.names.fullname" . }}
  {{- end }}
  {{- end }}
  ports:
  - name: {{ $svc.name | default "http"}}
    containerPort: {{ $svc.targetPort | default $svc.port }}
    protocol: {{ $svc.protocol | default "TCP" }}
  volumeMounts:
  {{- range $index, $PVC := .Values.persistence }}
  {{- if $PVC.enabled }}
  - mountPath: {{ $PVC.mountPath | default (printf "/%v" $index) }}
    name: {{ $index }}
  {{- if $PVC.subPath }}
    subPath: {{ $PVC.subPath }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- if .Values.additionalVolumeMounts }}
    {{- toYaml .Values.additionalVolumeMounts | nindent 2 }}
  {{- end }}
  {{- range $probeName, $probe := .Values.probes }}
  {{- if $probe.enabled -}}
    {{- "" | nindent 2 }}
    {{- $probeName }}Probe:
    {{- if $probe.custom -}}
      {{- $probe.spec | toYaml | nindent 4 }}  
    {{- else }}
      {{- "tcpSocket:" | nindent 4 }}
        {{- printf "port: %v" $svcPort  | nindent 6 }}
      {{- printf "initialDelaySeconds: %v" $probe.spec.initialDelaySeconds  | nindent 4 }}
      {{- printf "failureThreshold: %v" $probe.spec.failureThreshold  | nindent 4 }}
      {{- printf "timeoutSeconds: %v" $probe.spec.timeoutSeconds  | nindent 4 }}
      {{- printf "periodSeconds: %v" $probe.spec.periodSeconds | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- end }}
  {{- with .Values.resources }}
  resources:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
