#!/usr/bin/env python3
import argparse
import base64
import json
import sys

import boto3

def requested_policy_version(policy_arn):
    """
    Takes a policy ARN string and checks if a version was specified using the following format:

    arn:aws:iam::aws:policy/aws-service-role/AccessAnalyzerServiceRolePolicy:myversion

    This works by making use of the fact that colons are not allowed in IAM policy names.
    """
    if policy_arn[policy_arn.rfind('/'):].find(':') != -1:
        return policy_arn[policy_arn.rfind(':') + 1:]

    return False

def fetch_policies(policy_arns):
    iam_client = boto3.client("iam")

    policy_bodies = []

    for arn in json.loads(policy_arns):
        # Check if a specific version of a policy was requested
        policy_version = requested_policy_version(arn)

        # Get the policy document
        if policy_version:
            policy_document = iam_client.get_policy_version(
                PolicyArn=arn[:arn.rfind(':')],
                VersionId=policy_version
            )['PolicyVersion']['Document']
            policy_document_b64 = base64.b64encode(json.dumps(policy_document).encode())
        else:
            policy_default_version = iam_client.get_policy(PolicyArn=arn)['Policy']['DefaultVersionId']
            policy_document = iam_client.get_policy_version(
                PolicyArn=arn,
                VersionId=policy_default_version
            )['PolicyVersion']['Document']

        policy_bodies.append(policy_document)

    return policy_bodies


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--debug",
        "-d",
        help="Debug mode, reads specified file as input as it would normally with stdin input.",
    )
    parser.add_argument(
        "--log", "-l", help="Logs input JSON to the specified file"
    )

    args = parser.parse_args()

    if args.log:
        query = json.load(sys.stdin)
        with open(args.log, "w") as terraformQuery:
            json.dump(query, terraformQuery)
    elif args.debug:
        with open(args.debug, "rb") as terraformQuery:
            query = json.load(terraformQuery)
    else:
        query = json.load(sys.stdin)

    # Output the list of policies to Terraform (base64 encoded because
    # terraform can't handle anything but strings being returned from external
    # datasources)
    output = {"b64_policies": ""}

    policies = fetch_policies(query['policy_arns'])

    for policy in policies:
        if output["b64_policies"] == "":
            output["b64_policies"] += "{}".format(
                base64.b64encode(json.dumps(policy).encode()).decode()
            )
        else:
            output["b64_policies"] += ",{}".format(
                base64.b64encode(json.dumps(policy).encode()).decode()
            )
    output['policy_count'] = str(len(policies))

    json.dump(output, sys.stdout, indent=2)
    sys.stdout.write("\n")
