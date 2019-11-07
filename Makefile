# http://clarkgrubb.com/makefile-style-guide

MAKEFLAGS += --warn-undefined-variables --no-print-directory
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.DELETE_ON_ERROR:
.SUFFIXES:


.PHONY: help
help:
	@echo "Available make targets:"
	@egrep '^(.+)\:\ ##\ (.+)' ${MAKEFILE_LIST} | column -t -c 2 -s ':#'

.PHONY: README.md
README.md: ## Updates README.md using terraform-docs
	@echo "Removing everything from the Inputs section onwards"
	printf '%s\n' "`awk '/## Inputs/{exit}1' README.md`" > README.tmp
	@echo "Adding terraform-docs generated Inputs and Outputs to the end of README.md"
	printf '\n%s\n' "`terraform-docs md .`" >> README.tmp
	mv README.tmp README.md

.PHONY: tests
tests: ## Runs tests
	@if ! python -c "import pytest" &>/dev/null; then echo "The tests require pytest. Please install pytest and re run."; exit 1; fi
	@cd tests/python && pytest -v

.PHONY: test-role-assume
test-role-assume:
	@CREDS=( $$(aws sts assume-role --role-arn arn:aws:iam::483560084512:role/terraform-20191107190744919200000002 --role-session-name test --query Credentials.[AccessKeyId,SecretAccessKey] --output text) ); \
		echo "export AWS_ACCESS_KEY_ID=\"$${CREDS[0]}\"; export AWS_SECRET_ACCESS_KEY=\"$${CREDS[1]}\";";