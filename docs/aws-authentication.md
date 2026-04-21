# AWS Authentication and IAM Permissions

This document explains how Terraform authenticates to AWS and which IAM permissions are required to run the infrastructure for this lab.

The repository intentionally avoids managing credentials directly and expects authentication to be configured locally.

---

# Authentication Model

Terraform authenticates using a **local AWS CLI profile**.

Example configuration:

aws configure --profile lab

Terraform will then automatically use those credentials.

Example provider configuration used in this project:

provider "aws" {
  region  = var.aws_region
  profile = "lab"
}

---

# Important Security Note

This repository **does not manage IAM users, credentials, or access keys**.

Authentication must be configured locally before running Terraform.

This design decision follows common infrastructure-as-code security practices:

- credentials should not be stored in repositories
- authentication should be managed externally
- infrastructure code should remain environment-agnostic

---

# Recommended Authentication Method

For enterprise or production environments, the recommended authentication model is:

**AWS IAM Identity Center (SSO)**

Advantages include:

- short-lived credentials
- centralized identity management
- improved auditability
- elimination of long-lived access keys

For the purpose of this lab, a **dedicated IAM user with programmatic access** may be used for simplicity.

---

# Required IAM Permissions

Terraform requires permissions to provision the infrastructure used in this lab.

These include permissions to manage:

- EC2 instances
- VPC networking
- subnets
- internet gateways
- route tables
- security groups
- EC2 key pairs
- EC2 image discovery
- Windows instance password retrieval

The reference policy used during **Phase 1** is stored in:

terraform/policies/phase1-ec2-lab-policy.json

This file documents the minimum permissions required to bootstrap the lab infrastructure.

---

# Attaching the Policy

1. Open the **AWS IAM Console**

2. Navigate to:

IAM → Policies → Create Policy

3. Select **JSON**

4. Paste the contents of:

terraform/policies/phase1-ec2-lab-policy.json

5. Create the policy

6. Attach the policy to the IAM user used by Terraform.

---

# Validating AWS Access

After attaching the policy and configuring the AWS CLI profile, validate access with:

aws sts get-caller-identity --profile lab

Example output:

{
 "UserId": "...",
 "Account": "...",
 "Arn": "arn:aws:iam::ACCOUNT_ID:user/rubia-lab-terraform"
}

If this command works successfully, Terraform should be able to authenticate and provision infrastructure.

---
