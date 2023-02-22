# 1Password SCIM bridge Helm chart

This is the offical Helm chart for deploying the 1Password SCIM bridge.

The chart exists to facilitate our one-click deployment options for the [Google Cloud Marketplace](https://console.cloud.google.com/marketplace/product/agilebits-public/op-scim-bridge) and [DigitalOcean Marketplace](https://marketplace.digitalocean.com/apps/1password-scim-bridge) applications. With this in mind the chart is tailored to our specific use case and will likely not meet the requirements of every configuration option or deployment scenario. For more general purpose deployment options please see our [1Password/scim-examples](https://github.com/1Password/scim-examples) repository.

## Installation guide

### Install Helm

Install the latest version of Helm. See [installing Helm](https://helm.sh/docs/intro/install/) from the official Helm documentation.

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

## Available charts

* [1Password SCIM bridge](https://github.com/1Password/op-scim-helm/tree/main/charts/op-scim-bridge)

## Resource Recommendations

The default resource recommendations for the SCIM bridge and Redis deployments are acceptable in most scenarios, but they fall short in high volume deployments where there is a large number of users and/or groups. 

We strongly recommend increasing both the SCIM bridge and Redis deployments.

Our current default resource requirements for the SCIM bridge (defined in [values.yaml](https://github.com/1Password/op-scim-helm/blob/main/charts/op-scim-bridge/values.yaml#L104)) and Redis (defined in [values.yaml](https://github.com/1Password/op-scim-helm/blob/main/charts/op-scim-bridge/values.yaml#L205)) are:

| Expected Provisioned Users | Resources |
| ---- | ---- |
| 1-100  | Default  |
| 100-5000  | High Volume Deployment  |
| 5000+  | Very High Volume Deployment  |

<details>
  <summary>Default</summary>

  ```yaml
requests:
  cpu: 125m
  memory: 256M

limits:
  cpu: 250m
  memory: 512M
```
</details>

These values can be scaled down again after the high volume deployment.

<details>
  <summary>High Deployment</summary>

  ```yaml
  requests:
    cpu: 500m
    memory: 512M

  limits:
    cpu: 1000m
    memory: 1024M
  ```
</details>

<details>
  <summary>Very High Deployment</summary>
     
  ```yaml
  requests:
    cpu: 1000m
    memory: 1024M

  limits:
    cpu: 2000m
    memory: 2048M
  ```
</details>

### Updating resources

Updating the default values is a two-step process:

1. Create a new file named `override.yaml` in the root directory of the `op-scim-helm` project, and copy the below content in this new file. We have provided the proposed recommendations for you.

```yaml
# SCIM configuration options
scim:
  # resource sets the requests and/or limits for the SCIM bridge pod
  resources:
    requests:
      cpu: 500m
      memory: 512M
    limits:
      cpu: 1000m
      memory: 1024M
# Redis configuration options
redis:
  # resource sets the requests and/or limits for the Redis pod
  requests:
    cpu: 500m
    memory: 512M

  limits:
    cpu: 1000m
    memory: 1024M
```
2. Upgrade the `op-scim-bridge` chart with the updated `override.yaml` values:

```shell
helm upgrade -f override.yaml op-scim-bridge 1password/op-scim-bridge
```

If successful, you should see the message `Release "op-scim-bridge" has been upgraded. Happy Helming!`

You can verify the changes by describing the deployment with `kubectl` and referencing the Limits and Requests sections of the `op-scim-bridge` container:

```shell
kubectl describe deploy op-scim-bridge
```

For further understanding of how Kubernetes measures resources, please see [Resource units in Kubernetes](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes)

Please reach out to our [support team](https://support.1password.com/contact/) if you need help with the configuration or to tweak the values for your deployment.
