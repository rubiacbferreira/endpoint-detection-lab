# Documentation Index

This directory contains the technical documentation for the **Endpoint Detection Lab**.

The goal of this documentation is to organize the project into clear domains:

- infrastructure
- authentication and access
- detection engineering
- MITRE ATT&CK alignment
- AI-assisted alert enrichment

---

## Documents

### Lab Architecture

File: `lab-architecture.md`

Describes the overall architecture of the lab, design principles, infrastructure components, future phases and the telemetry-to-detection pipeline.

### AWS Authentication and IAM Permissions

File: `aws-authentication.md`

Describes how Terraform authenticates to AWS, the local authentication model used in this lab, the recommended enterprise approach, and the IAM permissions required for provisioning.

### Detection Engineering

File: `detection-engineering.md`

Introduces the detection engineering concepts used in this project, including telemetry, detection workflow, testing and false positive reduction.

### MITRE ATT&CK Framework

File: `mitre-framework.md`

Explains how MITRE ATT&CK is used in the lab to guide detections, map techniques and evaluate coverage.

### AI-Assisted Detection and Alert Enrichment

File: `ai-enrichment.md`

Describes how AI may be used to enrich alerts, assist triage and support detection engineering workflows.

---

## Suggested Reading Order

For readers exploring the project for the first time, the recommended order is:

1. `lab-architecture.md`
2. `aws-authentication.md`
3. `detection-engineering.md`
4. `mitre-framework.md`
5. `ai-enrichment.md`

---

## Documentation Goals

This documentation is designed to:

- explain the purpose of the lab
- document technical decisions
- organize security concepts clearly
- serve as a reference for future lab phases

As the project evolves, additional documents may be added to cover:

- telemetry pipeline details
- Elastic Stack integration
- attack simulation scenarios
- detection rule examples
- automation workflows
