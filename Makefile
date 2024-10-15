SHELL := /bin/bash
.SHELLFLAGS = -ec
.ONESHELL:
.SILENT:

.PHONY: help
help:
	grep -E '^\.PHONY: [a-zA-Z0-9_-]+ .*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = "(: |##)"}; {printf "\033[36m%-30s\033[0m %s\n", $$2, $$3}'

.PHONY: create-tag
create-tag: ## Create and push git tag.
	if [ -z ${tag} ] || [ -z ${msg} ]; then
		echo "You should provide a tag and a msg."
		echo "Like following 'make create-tag tag=v0.1 msg=test_tag'"
		exit 1
	fi
	git tag -a ${tag} -m ${msg}
	git push --tags
