# 1Password SCIM bridge

This repository defines the Helm chart for the 1Password SCIM bridge application.

We intend to use this as a repository that can be referenced in our various kubernetes marketplace solutions. It may also be used outside of that context with an appropriate deployment script.

**Homepage:** https://support.1password.com/scim

## Maintainers

| Name | Email |
| ---- | ----- |
| 1Password Provisioning Team | support+scim@1password.com |

## Dependencies

| Repository | Name | Version |
| ---------- |------|---------|
| [bitnami](https://github.com/bitnami/charts) | [redis](https://github.com/bitnami/charts/tree/master/bitnami/redis) | 12.0.0 |

## Prerequisites

You will need Helm installed to use this chart. Get the latest [Helm](https://github.com/kubernetes/helm#install) release.

## Installation

### Add repository

```shell
helm repo add 1password https://raw.githubusercontent.com/1password/op-scim-helm/main
helm repo update
```

### Install chart

```shell
helm install my-release 1password/op-scim-bridge
```

### Uninstall chart

```shel
helm uninstall my-release
```

## Values

The values are split into two sections:
- [scim](#scim) options
- [redis](#redis) options

### scim

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| name | string | `op-scim-bridge` | SCIM bridge name. |
| version | string | `major.minor.patch` | SCIM bridge verion. |
| credentialsVolume | object | `{}` | Use a volume for the SCIM bridge credentials. See [credentialsVolume](#credentialsVolume) for details. |
| credentialsSecret | object | `{}` | Use a secret for the SCIM bridge credentials. See [credentialsSecret](#credentialsSecret) for details. |
| imageRepository | string | `1password/scim` | 1Password SCIM bridge image. |
| imagePullPolicy | string | `Always` | Image pull policy. |
| imagePullSecrets | list | `[]` | Image pull secrets. |
| httpPort | int | `8080` | HTTP port. |
| httpsPort | int | `8443` | HTTPS port. |
| serviceType | string | `LoadBalancer` | Service type. |
| probes | object | `{ "liveness": { "enabled": true, "path": "/ping" } }` | Liveness probe that uses the `GET /ping` endpoint for health checks. |
| config | object | `{}` | SCIM bridge config options. See [config](#config) for details. |
| resources | object | `{}` | Resource requests and/or limits for the SCIM bridge pod. |
| annotations | object | `{}` | Additional annotations. |
| labels | object | `{}` | Additional labels. |
| podAnnotations | object | `{}` | Annotations for SCIM bridge pod. |
| podLabels | object | `{}` | Labels for SCIM bridge pod. |
| nodeSelector | object | `{}` | Node selector for SCIM bridge pod. |
| affinity | object | `{}` | Affinity for SCIM bridge pod. |
| tolerations | list | `[]` | Tolerations for SCIM bridge pod. |

#### config

These values set available SCIM bridge configuation options. For details on the options see the help output of the `op-scim` binary (`./op-scim --help`).

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| redisURL | string | `redis://op-scim-bridge-redis-master:6379` | Redis connection URL. |
| domain | string | N/A | Allowed 1Password sign in URL. Not set by default. |
| letsEncryptDomain | string | N/A | Domain to attempt to get a certificate for via Let's Encrypt domain. Not set by default. Set to `"-"` to disable Let's Encrypt functionality. |
| debug | bool | `false` | Enable `DEBUG` log level instead of the default `INFO` level. |
| jsonLogs | bool | `false` | Enable JSON log output. |
| prettyLogs | bool | `false` | Enable colorized log output. |


#### credentialsVolume

Note that you should configure accessing the SCIM bridge credentials through either the `credentialsVolume` or the `credentialsSecret`, and not both.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| name | string | `op-scim-bridge-credentials` | Volume name. |
| file | string | `scimsession` | File name. |
| accessModes | list | `[ReadWriteOnce]` | Access modes. |
| resources | object | `{ "requests": { "storage": "1Gi" } }` | The default storage request is `1Gi`. |
| storageClass | string | N/A | Storage class. The default is not set. Set to `"-"` to set value to `""`. `do-block-storage` is recommended for Digital Ocean. |

#### credentialsSecret

Note that you should configure accessing the SCIM bridge credentials through either the `credentialsVolume` or the `credentialsSecret`, and not both.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| name | string | `op-scim-bridge-credentials` | Secret name. |
| key | string | `scimsession` | Secret key. |
| value | string | `base64 encoded scimsession file` | Base64 encoded scimsession file. |

### redis

This is a small subset of possible the values that you can configure for Redis. See the [bitnami/redis](https://github.com/bitnami/charts/tree/master/bitnami/redis) chart documentation for more details.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| enabled | bool | `true` | Controls whether redis is deployed with the SCIM bridge. |
| image | object | `{ "registry": "docker.io", "repository": "bitnami/redis", "tag": "latest", "pullPolicy": "IfNotPreset" }` | Use the latest `bitnami/redis` image from `docker.io` and pull the image if it is not present. |
| cluster | object | `{"enabled": false }` | Redis cluster is disabled by default. |
| usePassword | bool | `false` | Use password is disabled by default. |


