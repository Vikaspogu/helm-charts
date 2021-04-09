# library

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: library](https://img.shields.io/badge/Type-library-informational?style=flat-square)

Function library for k8s-at-home charts

**WARNING: THIS CHART IS NOT MEANT TO BE INSTALLED DIRECTLY**

This is a [Helm Library Chart](https://helm.sh/docs/topics/library_charts/#helm). It's purpose is for grouping library logic between the k8s@home charts.

Since a lot of charts follow the same pattern this library was built to reduce maintenance cost between the charts that use it and try achieve a goal of being DRY.

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.

## Creating a new chart

Include this chart as a dependency in your `Chart.yaml` e.g.

```yaml
# Chart.yaml
dependencies:
- name: library
  version: 2.0.0
  repository: https://library-charts.k8s-at-home.com
```
Write a `values.yaml` with some basic defaults you want to present to the user e.g.

```yaml
#
# IMPORTANT NOTE
#
# This chart inherits from our library library chart. You can check the default values/options here:
# https://github.com/k8s-at-home/library-charts/tree/main/stable/library/values.yaml
#

image:
  repository: nodered/node-red
  pullPolicy: IfNotPresent
  tag: 1.2.5

strategy:
  type: Recreate

# See more environment variables in the node-red documentation
# https://nodered.org/docs/getting-started/docker
env: {}
  # TZ:
  # NODE_OPTIONS:
  # NODE_RED_ENABLE_PROJECTS:
  # NODE_RED_ENABLE_SAFE_MODE:
  # FLOWS:

service:
  port:
    port: 1880

ingress:
  enabled: false

persistence:
  data:
    enabled: false
    emptyDir: 
      enabled: false
    mountPath: /data
```

If not using a service, set the `service.enabled` to `false`.
```yaml
...
service:
  enabled: false
...
```

Add files to the `templates` folder.
```yaml
# templates/library.yaml
{{ include "library.all . }}

# templates/NOTES.txt
{{ include "library.notes.defaultNotes" . }}
```

If testing locally make sure you update the dependencies with:

```bash
helm dependency update
```

## Values

**Important**: When deploying an application Helm chart you can add more values from our library library chart [here](https://github.com/k8s-at-home/library-charts/tree/main/stable/library/)

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalVolumeMounts | list | `[]` |  |
| affinity | object | `{}` |  |
| annotations | object | `{}` |  |
| labels | object | `{}` |  |
| dnsPolicy | string | `"ClusterFirst"` |  |
| env | object | `{}` |  |
| envFrom | list | `[]` |  |
| envTpl | object | `{}` |  |
| envValueFrom | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| hostNetwork | bool | `false` |  |
| ingress.additionalIngresses | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| ingress.labels | object | `{}` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.config.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.config.enabled | bool | `false` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.config.size | string | `"1Gi"` |  |
| persistence.config.skipuninstall | bool | `false` |  |
| persistence.shared.emptyDir.enabled | bool | `true` |  |
| persistence.shared.enabled | bool | `false` |  |
| persistence.shared.mountPath | string | `"/shared"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| probes.liveness.custom | bool | `false` |  |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.spec.failureThreshold | int | `3` |  |
| probes.liveness.spec.initialDelaySeconds | int | `0` |  |
| probes.liveness.spec.periodSeconds | int | `10` |  |
| probes.liveness.spec.timeoutSeconds | int | `1` |  |
| probes.readiness.custom | bool | `false` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.spec.failureThreshold | int | `3` |  |
| probes.readiness.spec.initialDelaySeconds | int | `0` |  |
| probes.readiness.spec.periodSeconds | int | `10` |  |
| probes.readiness.spec.timeoutSeconds | int | `1` |  |
| probes.startup.custom | bool | `false` |  |
| probes.startup.enabled | bool | `true` |  |
| probes.startup.spec.failureThreshold | int | `30` |  |
| probes.startup.spec.initialDelaySeconds | int | `0` |  |
| probes.startup.spec.periodSeconds | int | `5` |  |
| probes.startup.spec.timeoutSeconds | int | `1` |  |
| replicas | int | `1` |  |
| resources | object | `{}` |  |
| secret | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.additionalPorts | list | `[]` |  |
| service.additionalServices | list | `[]` |  |
| service.annotations | object | `{}` |  |
| service.enabled | bool | `true` |  |
| service.labels | object | `{}` |  |
| service.port.name | string | `nil` |  |
| service.port.port | string | `nil` |  |
| service.port.protocol | string | `"TCP"` |  |
| service.port.targetPort | string | `nil` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `""` |  |
| strategy.type | string | `"RollingUpdate"` |  |
| tolerations | list | `[]` |  |

## Changelog

All notable changes to this application Helm chart will be documented in this file but does not include changes from our library library. To read those click [here](../library/README.md).

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

### [1.0.0]

#### Added

- Added support for using Helm template language.

