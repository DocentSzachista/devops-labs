{{/*
    Expand the name of the chart.
    */}}
    {{- define "my-backend.backend" -}}
    {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
    
    {{/*
    Create a default fully qualified app name.
    */}}
    {{- define "my-backend.backend" -}}
    {{- $name := default .Chart.Name .Values.nameOverride -}}
    {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
    