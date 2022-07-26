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