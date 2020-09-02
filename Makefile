package:
	helm package op-scim-bridge
	helm repo index . --merge index.yaml

lint:
	helm lint ./op-scim-bridge

test-install:
	helm install op-scim-bridge op-scim-1.4.4.tgz --create-namespace --namespace op-scim-bridge

get-latest-version:
	git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' git://gitlab.1password.io:2227/dev/b5/op.git
