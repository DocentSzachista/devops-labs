{{/*
    Expand the name of the chart.
    */}}
    {{- define "fiszki_backend.name" -}}
    {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
    
    {{/*
    Create a default fully qualified app name.
    */}}
    {{- define "fiszki_backend.fullname" -}}
    {{- $name := default .Chart.Name .Values.nameOverride -}}
    {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
    {{- end -}}
    