# HELP
.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

init: ## initialize environment
	sudo apt install -y python3-netaddr
	ansible-galaxy collection install -r ./collections/requirements.yml

deploy-k3s: ## packer build
	ansible-playbook site.yml

get-kube-config: ## download kubeconfig file
	mkdir -p ~/.kube
	scp -o StrictHostKeyChecking=no cloud-user@cobra-cp1.jsnouff.net:~/.kube/config ~/.kube/config

configure: ## configure k3s cluster
	ansible-playbook site.yml