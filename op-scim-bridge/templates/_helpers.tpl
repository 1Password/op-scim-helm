{{/*
Expand the name of the chart.
*/}}
{{- define "op-scim-bridge.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "op-scim-bridge.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "op-scim-bridge.labels" -}}
helm.sh/chart: {{- include "op-scim-bridge.chart" . -}}
{{- include "op-scim-bridge.selectorLabels" . -}}
{{- if .Chart.AppVersion -}}
app.kubernetes.io/version: {{- .Chart.AppVersion | quote -}}
{{- end -}}
app.kubernetes.io/managed-by: {{- .Release.Service -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "op-scim-bridge.selectorLabels" -}}
app.kubernetes.io/name: {{- include "op-scim-bridge.name" . -}}
app.kubernetes.io/instance: {{- .Release.Name -}}
{{- end -}}


{{- define "helm-toolkit.utils.joinListWithComma" -}}
{{- $local := dict "first" true -}}
{{- range $k, $v := . -}}{{- if not $local.first -}},{{- end -}}{{- $v -}}{{- $_ := set $local "first" false -}}{{- end -}}
{{- end -}}

{{- define "op-scim-bridge.port" -}}
{{- if .Values.scim.tls.enabled -}}
{{- .Values.scim.httpsPort  -}}
{{- else -}}
{{- .Values.scim.httpPort  -}}
{{- end -}}
{{- end -}}

{{- define "op-scim-bridge.url" -}}
{{- if .Values.scim.tls.enabled -}}
https://{{- tpl .Values.scim.name . -}}:{{- .Values.scim.httpsPort  -}}
{{- else -}}
http://{{- tpl .Values.scim.name . -}}:{{- .Values.scim.httpPort  -}}
{{- end -}}
{{- end -}}