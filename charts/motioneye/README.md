# motioneye

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![AppVersion: v2.0.0](https://img.shields.io/badge/AppVersion-v2.0.0-informational?style=flat-square)

Garage opener application for home

## Source Code

* <https://github.com/Vikaspogu/helm-charts/tree/master/charts/motioneye>

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
helm install motioneye vikaspogu/motioneye
```

## Installing the Chart

To install the chart with the release name `motioneye`

```console
helm install motioneye vikaspogu/motioneye
```

## Uninstalling the Chart

To uninstall the `motioneye` deployment

```console
helm uninstall motioneye
```

The command removes all the Kubernetes components associated with the chart **including persistent volumes** and deletes the release.

## Configuration

Read through the [values.yaml](./values.yaml) file. It has several commented out suggested values.
Other values may be used from the [values.yaml](https://github.com/Vikaspogu/helm-charts/blob/master/charts/library/values.yaml) from the [common library](https://github.com/Vikaspogu/helm-charts/tree/master/charts/library).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

```console
helm install motioneye \
  --set env.TZ="America/New York" --set image.tag=0.42-armhf \
    vikaspogu/motioneye
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart.

```console
helm install motioneye vikaspogu/motioneye -f values.yaml
```

## Custom configuration

N/A

## Chart Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Set Pod affinity rules |
| fullnameOverride | string | `""` | Set to override the Full Name of resources |
| image.pullPolicy | string | `"IfNotPresent"` | Docker image pull policy |
| image.repository | string | `"ccrisan/motioneye"` | Docker registry/repository to pull the image from |
| image.tag | string | `"0.42-amd64"` | Version/Arch of Docker image to use. Change to `0.42-armhf` for RaspberyPi. |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` | annotations to configure your Ingress. See your Ingress Controller's Docs for more info. |
| ingress.enabled | bool | `false` | Enables the use of an Ingress Controller to front the Service and provide HTTPS |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[]}]` | list of hosts and their paths that ingress controller should repsond to. |
| ingress.tls | list | `[]` | list of TLS configurations |
| nameOverride | string | `""` | Set to overrides the name of resources |
| nodeSelector | object | `{}` | Node Selector configuration |
| persistence.config.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.config.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.config.enabled | bool | `false` | Enables persistence for the config directory |
| persistence.config.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.config.size | string | `"8Gi"` | size/capacity of the PVC |
| persistence.config.storageClass | string | `nil` | (Optional) StorageClass to use for the PVC |
| persistence.data.accessMode | string | `"ReadWriteOnce"` | [access mode](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) to use for the PVC |
| persistence.data.annotations | object | `{}` | (Optional) annotations to add to the PVC |
| persistence.data.enabled | bool | `false` | Enables persistence for the data directory |
| persistence.data.existingClaim | string | `nil` | Set to use an existing PVC instead of creating a new one. |
| persistence.data.size | string | `"24Gi"` | size/capacity of the PVC |
| persistence.data.storageClass | string | `nil` | (Optional) StorageClass to use for the PVC |
| podSecurityContext | object | `{}` | Set Pod security contexts |
| resources | object | `{}` | Set resource limits/requests for the Pod(s) |
| securityContext | object | `{}` | Set Security Context |
| service.port | int | `80` | Port the Service should communicate on |
| service.type | string | `"ClusterIP"` | Type of Service to use |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| tolerations | list | `[]` | Node toleration configuration |
