{{/*
Return the full name of the chart
*/}}
{{- define "myapp.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Return the short name of the chart
*/}}
{{- define "myapp.name" -}}
{{- .Chart.Name -}}
{{- end -}}
