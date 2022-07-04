# 1Password SCIM bridge Helm Charts

This is the offical Helm Chart for deploying the 1Password SCIM bridge.

## Installation guide

### Install Helm

Install the latest version of Helm. See [installing Helm](https://helm.sh/docs/intro/install/) from the official Helm documentation.

### Add repository

```shell
helm repo add 1password  https://1password.github.io/op-scim-helm
helm repo update
```

### Install chart
****
```shell
helm install my-release 1password/op-scim-bridge
```

### Uninstall chart

```shell
helm uninstall my-release
```

## Available charts

* [1Password SCIM bridge](https://github.com/1Password/op-scim-helm/tree/main/op-scim-bridge)