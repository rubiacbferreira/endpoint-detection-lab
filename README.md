# Endpoint Detection Lab

A hands-on detection engineering lab built with Terraform, osquery and Elastic Stack.

The goal of this project is to simulate a realistic endpoint telemetry pipeline and experiment with detection engineering workflows aligned with MITRE ATT&CK.

---

## What this lab demonstrates

- Infrastructure-as-Code security labs
- Endpoint telemetry with osquery
- Detection engineering workflows
- MITRE ATT&CK mapping
- Alert enrichment
- AI-assisted security analysis

---

## Architecture

The lab architecture is documented in:

docs/lab-architecture.md

---

## AWS Authentication

Authentication and IAM permissions required to run this lab are documented in:

docs/aws-authentication.md

---

## Infrastructure

The infrastructure is provisioned using Terraform and includes:

- VPC
- Linux endpoint
- Windows endpoint
- security groups
- networking components

These machines act as simulated enterprise endpoints.


## Simulations (In Progress)

This repository includes scripts to simulate adversary behavior across endpoints:

- Linux: simulations/linux/
- Windows: simulations/windows/

These scripts are used to generate telemetry for detection validation.

At the current stage, simulations are executed manually for testing purposes.

Future versions of the lab will integrate these simulations into the instance bootstrap process, enabling automated telemetry generation.

## osquery Packs (In Progress)

Detection logic is being developed using osquery packs:

osquery/packs/

These packs define scheduled queries that will be executed on endpoints to automate detection workflows.

Integration with the osquery daemon is planned for future phases of the lab.

## Documentation

```markdown
# Documentation

Additional project documentation is available in:

- `docs/index.md`
- `docs/lab-architecture.md`
- `docs/aws-authentication.md`
- `docs/detection-engineering.md`
- `docs/mitre-framework.md`
- `docs/ai-enrichment.md`


## Learning Goals

This lab explores how detection engineering environments are built using:

- endpoint telemetry
- security analytics
- detection rules
- MITRE ATT&CK mapping
- automation
- AI-assisted workflows

---

## Related Article

A step-by-step walkthrough of building this lab is available here:

Medium article (coming soon)