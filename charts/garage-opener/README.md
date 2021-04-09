# garage-opener

![Version: 2.0.1](https://img.shields.io/badge/Version-2.0.1-informational?style=flat-square) ![AppVersion: v1.16.0](https://img.shields.io/badge/AppVersion-v1.16.0-informational?style=flat-square)

Garage opener application for home

## Source Code

* <https://github.com/vikaspogu/garage-opener>

## Requirements

Kubernetes: `>=1.16.0-0`

## Dependencies

| Repository | Name | Version |
|------------|------|---------|
| https://github.com/Vikaspogu/helm-charts/tree/master/charts/library | library | 1.0.0 |

## TL;DR

```console
helm repo add vikaspogu https://vikaspogu.dev/helm-charts/
helm repo update
helm install garage-opener vikaspogu/garage-opener
```

## Installing the Chart

To install the chart with the release name `garage-opener`

```console
helm install garage-opener vikaspogu/garage-opener
```

## Uninstalling the Chart

To uninstall the `garage-opener` deployment

```console
helm uninstall garage-opener
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/Vikaspogu/helm-charts/blob/master/charts/library/values.yaml) from the [common library](https://github.com/Vikaspogu/helm-charts/tree/master/charts/library).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install garage-opener \
  --set env.TZ="America/New York" \
    vikaspogu/garage-opener
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install garage-opener vikaspogu/garage-opener -f values.yaml
```

## Custom configuration

N/A