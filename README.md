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

| Key | Type | Default | Description |
|-----|------|---------|-------------|
|     |      |         |             |
