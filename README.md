# 1Password SCIM bridge Helm Chart

This is the offical Helm Chart for deploying the 1Password SCIM bridge.

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
helm install my-release 1password/op-scim
```

### Uninstall chart

```shell
helm uninstall my-release
```

## Available charts

- [1Password SCIM bridge](./charts/op-scim-bridge/)
