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
helm repo add 1password https://1password.github.io/op-scim-helm
helm repo update
```

### Install chart

```shell
helm install my-release 1password/op-scim-bridge
```

### Uninstall chart

```shell
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
| credentialsSecrets | object | `{}` | Use a secret for the SCIM bridge credentials. See [credentialsSecrets](#credentialsSecrets) for details. |
| imageRepository | string | `1password/scim` | 1Password SCIM bridge image. |
| imagePullPolicy | string | `Always` | Image pull policy. |
| imagePullSecrets | list | `[]` | Image pull secrets. |
| httpPort | int | `8080` | HTTP port. |
| httpsPort | int | `8443` | HTTPS port. |
| service | object | `{ "enabled": true, "type": "LoadBalancer" }` | Service configuration. |
| ingress | object | `{}` | Ingress configuration.  |
| probes | object | `{ "liveness": { "enabled": true, "path": "/ping" } }` | Liveness probe that uses the `GET /ping` endpoint for health checks. |
| config | object | `{}` | SCIM bridge config options. See [config](#config) for details. |
| resources | object | `{}` | Resource requests and/or limits for the SCIM bridge pod. |
| annotations | object | `{}` | Additional annotations. |
| labels | object | `{}` | Additional labels. |
| podAnnotations | object | `{}` | Annotations for SCIM bridge pod. |
| podLabels | object | `{}` | Labels for SCIM bridge pod. |
| nodeSelector | object | `{}` | Node selector for SCIM bridge pod. |
| affinity | object | `{ "podAntiAffinity": {} }` | Affinity for SCIM bridge pod. By default we configure pod anti-affinity to ensure redis and SCIM bridge pods are not scheduled on the same node. |
| tolerations | list | `[]` | Tolerations for SCIM bridge pod. |
| initContainers | object | `{}` | Configuration options for init containers. |
| replicaCount | int | `1` | Number of replicas in deployment. |
| autoscaling | object | `{}` | Configuration for `HorizontalPodAutoscaler` resource. Will override `replicaCount` when set. |
| podDisruptionBudget | object | `{}` | Configuration for `PodDisruptionBudget` resource. Requires more than 1 replica or `autoscaling` to be enabled to be effective. |
| serviceAccount | object | `{}` | Service account configuration. Default service account is used when disabled. |
| serviceMonitor | object | `{}` | Service monitor for Prometheus Operator. See [getting started](https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/user-guides/getting-started.md) guide.  |

#### config

These values set available SCIM bridge configuation options. For details on the options see the help output of the `op-scim` binary (`./op-scim --help`).

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| redisURL | string | `redis://op-scim-bridge-redis-master:6379` | Redis connection URL. |
| domain | string | unset | Allowed 1Password sign in URL. Not set by default. |
| letsEncryptDomain | string | unset | Domain to attempt to get a certificate for via Let's Encrypt domain. Not set by default. |
| debug | bool | `false` | Enable `DEBUG` log level instead of the default `INFO` level. |
| jsonLogs | bool | `false` | Enable JSON log output. |
| prettyLogs | bool | `false` | Enable colorized log output. |


#### credentialsVolume

Note that you should configure accessing the SCIM bridge credentials through either the `credentialsVolume` or the `credentialsSecrets`, and not both.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| name | string | `op-scim-bridge-credentials` | Volume name. |
| files | object | `{ "scimFile": "scimsession", "workspaceSettingsFile": "workspace-settings.json", "workspaceKeyFile":"workspace-credentials.json" }` | File names for SCIM bridge credentials. |
| accessModes | list | `[ReadWriteOnce]` | Access modes. |
| resources | object | `{ "requests": { "storage": "1Gi" } }` | The default storage request is `1Gi`. |
| storageClass | string | unset | Storage class. Set to `"—"` to set value to `""` in resulting application. `do-block-storage` is recommended for Digital Ocean. |

#### credentialsSecrets

Note that you should configure accessing the SCIM bridge credentials through either the `credentialsVolume` or the `credentialsSecrets`, and not both.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| scimsession | object | `{ “name”:”op-scim-bridge-credentials”, “key”: “scimsession”, “value_json”: “{}”, “value_base64”: “base64 encoded scimsession file” }` | scimsession secret definition. |
| workspaceSettings | object | `{ “name”:”op-scim-bridge-workspace-settings”, “key”: “workspace-settings”, “value_json”: “{}”, “value_base64”: “base64 encoded workspace settings file” }` | workspace settings secret definition. |
| workspaceCredentials | object | `{ “name”:”op-scim-bridge-workspace-credentials”, “key”: “workspace-credentials”, “value_json”: “{}”, “value_base64”: “base64 encoded workspace credentials file” }` | workspace credentials secret definition. |


### redis

This is a small subset of possible the values that you can configure for Redis. See the [bitnami/redis](https://github.com/bitnami/charts/tree/master/bitnami/redis) chart documentation for more details.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| enabled | bool | `true` | Controls whether redis is deployed with the SCIM bridge. |
| image | object | `{ "registry": "docker.io", "repository": "bitnami/redis", "tag": "latest", "pullPolicy": "IfNotPreset" }` | Use the latest `bitnami/redis` image from `docker.io` and pull the image if it is not present. |
| cluster | object | `{"enabled": false }` | Redis cluster is disabled by default. |
| usePassword | bool | `false` | Use password is disabled by default. |
| master.affinity | object | `{ "affinity": "podAntiAffinity": {} }` | Master affinity. By default we configure pod anti-affinity to ensure redis and SCIM bridge pods are not scheduled on the same node. Note that this configuration should be duplicated for the slave when not running redis in standalone mode. |
| master.resources | object | `{}` | Master resource requests and limits. |
| master.extraFlags | object | `{}` | Master extra flags. By default set a maximum memory limit and define the policy to use when key eviction is required. |
