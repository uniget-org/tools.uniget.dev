---
title: "{{ (datasource "tool").name }} {{ (datasource "tool").version }}"
publishDate: {{ (datasource "tool").publish_date }}
tags: {{ (datasource "tool").tags }}
summary: "{{ (datasource "tool").description }}"
---

## Description

{{ (datasource "tool").description }}

## Homepage

{{ (datasource "tool").homepage }}

## Repository

{{ (datasource "tool").repository }}

## Install

\`uniget install {{ (datasource "tool").name }}\`

## Dependencies

{{ range (datasource "tool").deps }}
- [{{ . }}](../{{ . }})
{{- end }}

## Code

[See code on GitLab](https://gitlab.com/uniget-org/tools/tree/main/tools/{{ (datasource "tool").name }})

## Package

[See package on GitLab](https://gitlab.com/uniget-org/tools/pkgs/container/uniget%2F{{ (datasource "tool").name }})

## Size

{{ (datasource "tool").size }}

## Platforms

{{ range (datasource "tool").platforms }}
- {{ . }}
{{- end }}

## Changelog (last 10)

| Date | Message | SHA |
|------|---------|-----|
{{ range (datasource "tool").history }}
| {{ .date }} | {{ .message }} | [{{ .commit }}](https://gitlab.com/uniget-org/tools/-/commit/{{ .commit }}) |
{{- end }}
