# Lab Architecture

This document describes the architecture and design decisions behind the **Endpoint Detection Lab**.

The objective of the lab is to simulate a realistic **detection engineering environment**, combining infrastructure-as-code, endpoint telemetry, and security analytics.

The environment is intentionally minimal so it can run safely inside a personal AWS account.

---

# Architecture Overview

Infrastructure is provisioned using **Terraform** and deployed into an isolated AWS environment.

Phase 1 provisions the following components:

- VPC
- subnet
- internet gateway
- route table
- security groups
- Linux EC2 instance
- Windows EC2 instance

These machines simulate **enterprise endpoints** that will generate telemetry for detection engineering experiments.

---

# High-Level Architecture

```mermaid
graph TD

A[AWS VPC] --> B[Linux Endpoint]
A --> C[Windows Endpoint]

B --> D[osquery Telemetry]
C --> D

D --> E[Elastic Stack]

E --> F[Detection Rules]
F --> G[MITRE ATT&CK Mapping]

G --> H[Alert Pipeline]
H --> I[Slack Notifications]
H --> J[AI-Assisted Enrichment]

This architecture represents the target evolution of the lab.

At a high level:

Terraform provisions the AWS infrastructure

Linux and Windows instances act as simulated enterprise endpoints

osquery collects endpoint telemetry

Elastic Stack ingests and analyzes telemetry

detection rules generate security alerts

alerts are mapped to MITRE ATT&CK techniques

enriched alerts may later be sent to Slack

AI-assisted workflows may be used to summarize and contextualize suspicious activity