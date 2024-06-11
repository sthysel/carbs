SHELL := /bin/bash
.SHELLFLAGS = -ec
LIMIT ?=NA
TAGS ?= "all"
ANSIBLE_ARGS = ""

ifeq (, $(shell which poetry))
	$(error "No poetry in $(PATH), do \$make env/bootstrap")
endif

-include .env

.ONESHELL:
.EXPORT_ALL_VARIABLES:

install/yay: ## Install the yay aur helper
	@source ./bootstrap.sh && install_yay

install/pipx: install/yay ## install pipx
	@source ./bootstrap.sh && install_pipx

install/poetry: install/pipx ## install poetry
	@source ./bootstrap.sh && install_poetry

install/ansible: install/poetry ## install ansible
	@source ./bootstrap.sh && install_ansible

.PHONY: bootstrap
# big old catch-all
bootstrap: ## bootstrap CARBS
	@source ./bootstrap.sh && bootstrap

qa/install-pre-commit-hooks:  ## install pre-commit hooks
	poetry run pre-commit install

.PHONY: qa/all
qa/all:  ## run pre-commit QA pipeline on all files
	poetry run pre-commit run --all-files

deploy: ## Deploy against inventory
	echo "Limiting deployment to ${LIMIT}"
	poetry run ansible-playbook \
    -v \
		--user thys \
		--inventory inventories/ \
		--limit ${LIMIT} \
		--tags ${TAGS} \
		provision.yml

carbs: ## Install CARBS on local machine
	poetry run ansible-playbook \
    -v \
		--user $USER \
		--inventory inventories/ \
		--limit ${LIMIT} \
		--tags ${TAGS} \
		provision.yml

.PHONY: dotfiles
dotfiles:  ## link in the dotfiles 
	stow -v --dir ./dotfiles --target ~ --dotfiles .

.PHONY: clean/broken-links
clean/broken-links:  ## clean dangling links
	find ~/.local/bin -xtype l -exec rm {} \;
	find ~/.config -xtype l -exec rm {} \;

.DEFAULT_GOAL := help
.PHONY: help
help: ## Print Makefile help
	@grep --no-filename -E '^[a-zA-Z_\/-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


