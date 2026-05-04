{{/*
Expand the name of the chart.
*/}}
{{- define "openlit-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "openlit-controller.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "openlit-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "openlit-controller.labels" -}}
helm.sh/chart: {{ include "openlit-controller.chart" . }}
{{ include "openlit-controller.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: openlit
{{- if .Values.additionalLabels }}
{{ toYaml .Values.additionalLabels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "openlit-controller.selectorLabels" -}}
app.kubernetes.io/name: {{ include "openlit-controller.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ServiceAccount name
*/}}
{{- define "openlit-controller.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "openlit-controller.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Resolve the OpenLIT Kubernetes service name.

Priority (highest to lowest):
  1. config.openlitServiceName — explicit override for standalone deployments.
  2. Auto-derive — mirrors the parent "openlit" chart's fullname logic so the
     name is correct when deployed as a subchart regardless of release name.
*/}}
{{- define "openlit-controller.parentServiceName" -}}
{{- if .Values.config.openlitServiceName }}
{{- .Values.config.openlitServiceName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $parentName := "openlit" }}
{{- if contains $parentName .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $parentName | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Build a host string for the parent OpenLIT service.

When config.openlitNamespace is set (standalone / cross-namespace), produce a
fully-qualified DNS name.  Otherwise use the short service name (same namespace).
*/}}
{{- define "openlit-controller.parentServiceHost" -}}
{{- $svc := include "openlit-controller.parentServiceName" . }}
{{- if .Values.config.openlitNamespace }}
{{- printf "%s.%s.svc.cluster.local" $svc .Values.config.openlitNamespace }}
{{- else }}
{{- $svc }}
{{- end }}
{{- end }}

{{/*
Resolve the OpenLIT dashboard URL.

Priority: explicit config.openlitUrl > auto-derived from service name + namespace.
*/}}
{{- define "openlit-controller.openlitUrl" -}}
{{- if .Values.config.openlitUrl }}
{{- .Values.config.openlitUrl }}
{{- else }}
{{- printf "http://%s:%s" (include "openlit-controller.parentServiceHost" .) "3000" }}
{{- end }}
{{- end }}

{{/*
Resolve the OTLP endpoint.

Priority: explicit config.otlpEndpoint > auto-derived from service name + namespace.
*/}}
{{- define "openlit-controller.otlpEndpoint" -}}
{{- if .Values.config.otlpEndpoint }}
{{- .Values.config.otlpEndpoint }}
{{- else }}
{{- printf "http://%s:%s" (include "openlit-controller.parentServiceHost" .) "4318" }}
{{- end }}
{{- end }}

{{/*
Image reference
*/}}
{{- define "openlit-controller.image" -}}
{{- $tag := default .Chart.AppVersion .Values.image.tag }}
{{- printf "%s:%s" .Values.image.repository $tag }}
{{- end }}
