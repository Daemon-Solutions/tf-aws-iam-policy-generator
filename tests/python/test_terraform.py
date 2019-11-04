#!/usr/bin/env python3
import hcl
import json
import os
import os.path
import pytest
import subprocess
import pdb

test_dir = os.path.normpath(
    os.path.join(os.path.realpath(__file__), "..", "..", "terraform")
)

ignore_files = ['.gitignore', 'requirements.txt', 'Makefile', 'README.md']

def hcl_get_statement_id_list():
    # Check that there are Sids (Statement IDs) for all statements in the module
    module_root_path = os.path.join(os.path.dirname(__file__), '..', '..')
    statement_ids = []

    with os.scandir(module_root_path) as path_iterator:
        for path in path_iterator:
            if os.path.isdir(path):
                continue

            if os.path.split(path)[1] in ignore_files:
                continue

            with open(path, 'r') as tf_file:
                hcl_obj = hcl.load(tf_file)


            if 'data' in hcl_obj:
                if 'aws_iam_policy_document' in hcl_obj['data']:
                    for policy_name in hcl_obj['data']['aws_iam_policy_document'].keys():
                        statements = hcl_obj['data']['aws_iam_policy_document'][policy_name]['statement']
                        if not isinstance(statements, list):
                            statements = [hcl_obj['data']['aws_iam_policy_document'][policy_name]['statement']]

                        for statement in statements:
                            statement_ids.append(statement['sid'])
    return statement_ids

def test_terraform_statements_sids_exists():
    # Check that there are Sids (Statement IDs) for all statements in the module
    module_root_path = os.path.join(os.path.dirname(__file__), '..', '..')

    with os.scandir(module_root_path) as path_iterator:
        for path in path_iterator:
            if os.path.isdir(path):
                continue

            if os.path.split(path)[1] in ignore_files:
                continue

            with open(path, 'r') as tf_file:
                try:
                    hcl_obj = hcl.load(tf_file)
                except Exception as e:
                    pytest.fail("reading hcl file: {} with error {}".format(path, e))


            if 'data' in hcl_obj:
                if 'aws_iam_policy_document' in hcl_obj['data']:
                    for policy_name in hcl_obj['data']['aws_iam_policy_document'].keys():
                        statements = hcl_obj['data']['aws_iam_policy_document'][policy_name]['statement']
                        if not isinstance(statements, list):
                            statements = [hcl_obj['data']['aws_iam_policy_document'][policy_name]['statement']]

                        for statement in statements:
                            assert 'sid' in statement


def test_terraform():
    # Check Terraform version
    terraform_version_proc = subprocess.run(
        ["terraform", "version", "-no-color"], cwd=test_dir, capture_output=True
    )

    assert str(terraform_version_proc.stdout).find('0.11.14') != -1

    # Run Terraform init
    terraform_init_proc = subprocess.run(
        ["terraform", "init", "-no-color"], cwd=test_dir, capture_output=True
    )
    assert terraform_init_proc.returncode == 0

    # Run Terraform plan and confirm there are expected changes
    terraform_plan_proc = subprocess.run(
        ["terraform", "plan", "-no-color", "-detailed-exitcode", "-out", "test.tfplan"],
        cwd=test_dir,
        capture_output=False,
    )
    assert terraform_plan_proc.returncode == 2 or terraform_plan_proc.returncode == 0

    # Apply the changes to create the policies in the AWS account
    terraform_apply_proc = subprocess.run(
        ["terraform", "apply", "test.tfplan"],
        cwd=test_dir,
        capture_output=False,
    )
    assert terraform_apply_proc.returncode == 0

    # Read the Terraform state file
    with open(os.path.join(test_dir, "terraform.tfstate")) as state_file:
        tfstate = json.load(state_file)

    # Terraform state tests
    for module in tfstate['modules']:
        if module["path"] == ["root"]:
            policy_json = json.loads(module["outputs"]["policies"]["value"][0]["policies"])

    # Get a list of all statement IDs
    statement_ids = hcl_get_statement_id_list()
    statement_ids_found = {}

    # Create hash so we can track if they are found in the created policy
    for statement_id in statement_ids:
        statement_ids_found[statement_id] = False

    # Check for existence in the policies
    for statement in policy_json['Statement']:
        statement_ids_found[statement['Sid']] = True

    # Assert that each are found
    for statement_id in statement_ids_found.keys():
        try:
            if statement_ids_found[statement_id] == False:
                raise Exception("Untested policies found please update the test Terraform code to test all the policies: {}".format(statement_ids_found))
        except Exception as MissingStatementException:
            pytest.fail("Untested policies found: {}".format(MissingStatementException))

    # Destroy to clean up the policies
    terraform_destroy_proc = subprocess.run(
        ["terraform", "destroy", "-no-color", "-auto-approve", "."],
        cwd=test_dir,
        capture_output=True,
    )
    assert terraform_destroy_proc.returncode == 0


if __name__ == "__main__":
    statement_ids = hcl_get_statement_id_list()
