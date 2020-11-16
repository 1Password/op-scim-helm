# op-scim-helm

![Version: 1.6.1](https://img.shields.io/badge/Version-1.6.1-informational?style=flat-square) ![AppVersion: v1.6.0](https://img.shields.io/badge/AppVersion-v1.6.0-informational?style=flat-square)

This repo defines the helm chart for the 1Password SCIM Bridge application.

We intend to use this as a repository that can be referenced in our various kubernetes marketplace solutions. It may also be used outside of that context with an appropriate deployment script.


The 1Password SCIM bridge

**Homepage:** <https://support.1password.com/scim>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| 1Password Platform Integrations Team | support+business@1password.com |  |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | redis | 12.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Pod affinity for SCIM pods |
| fullnameOverride | string | `""` | Override the full name, see helpers for more information |
| image.pullPolicy | string | `"IfNotPresent"` | SCIM image pull policy |
| image.repository | string | `"1password/scim"` | SCIM image repository |
| image.tag | string | `"v1.6.0"` | SCIM image tag, overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | Credentials secrets to use to pull the image |
| ingress.annotations | object | `{}` | Additionnal annotations for the Ingress |
| ingress.enabled | bool | `false` | Enable or not Ingress |
| ingress.hosts[0].host | string | `"scim.example.com"` |  |
| ingress.hosts[0].paths[0] | string | `"/"` |  |
| ingress.tls | list | `[{"hosts":["scim.example.com"],"secretName":"scim-example-com-tls"}]` | TLS configuration for the ingress |
| nameOverride | string | `""` | Name to override resources names |
| nodeSelector | object | `{}` | Node selector for SCIM pods |
| podAnnotations | object | `{}` | Additionnal annotations on SCIM pods |
| podSecurityContext | object | `{}` |  |
| redis | object | `{"cluster":{"enabled":false},"enabled":true,"image":{"pullPolicy":"IfNotPresent","registry":"docker.io","repository":"bitnami/redis","tag":"6.0.9-debian-10-r13"},"usePassword":false}` | Redis configuration, check [the upstream configuration](https://github.com/bitnami/charts/blob/master/bitnami/redis) |
| replicaCount | int | `1` |  |
| resources | object | `{}` | Resources requests/limits for the SCIM pods |
| scim.sessionFile | string | `"scimsession"` | Session file for SCIM application |
| scim.userHome | string | `"/home/scimuser"` | User home directoy for SCIM application |
| scim.userID | int | `999` | Default user ID for SCIM application |
| scim.userName | string | `"scimuser"` | User name for SCIM application |
| securityContext | object | `{}` |  |
| service.type | string | `"LoadBalancer"` | Service type, depends if you use an ingress controller or not |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| storageClassName | string | `"do-block-storage"` | Storage class for the SCIM PVC |
| tolerations | list | `[]` | Pod toleration for SCIM pods |