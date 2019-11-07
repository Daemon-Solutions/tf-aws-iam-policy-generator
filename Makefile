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
test-role-assume: ## Assume test role and output bash export commands for the credentials
	@CREDS=( $$(aws sts assume-role --role-arn arn:aws:iam::483560084512:role/terraform-20191107190744919200000002 --role-session-name test --query Credentials.[AccessKeyId,SecretAccessKey] --output text) ); \
		echo "export AWS_ACCESS_KEY_ID=\"$${CREDS[0]}\"; export AWS_SECRET_ACCESS_KEY=\"$${CREDS[1]}\";";

.PHONY: test-role-console
test-role-console: ## Assume the test role and open the console using it's credentials
	@CREDS=( $$(aws sts assume-role --role-arn arn:aws:iam::483560084512:role/terraform-20191107190744919200000002 --role-session-name test --query Credentials.[AccessKeyId,SecretAccessKey,SessionToken] --output text) ) && \
		SIGNIN_TOKEN=$$(curl -qs "https://signin.aws.amazon.com/federation?Action=getSigninToken&Session=%7B+%22sessionId%22%3A+%22$${CREDS[0]}%22%2C+%22sessionKey%22%3A+%22$${CREDS[1]}%22%2C+%22sessionToken%22%3A+%22$${CREDS[2]}%22+%7D%0A" | cut -d'"' -f 4) && \
		CONSOLE_URL="https://signin.aws.amazon.com/federation?Action=login&Issuer=&Destination=https%3A%2F%2F$${AWS_DEFAULT_REGION}.console.aws.amazon.com%2F&SigninToken=$${SIGNIN_TOKEN}&SessionDuration=43200" && \
		echo "$${CONSOLE_URL}"