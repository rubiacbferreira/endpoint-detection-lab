# MITRE ATT&CK Framework

This document explains how the MITRE ATT&CK framework is used within this lab.

MITRE ATT&CK is a globally recognized knowledge base of adversary tactics and techniques based on real-world observations.

It provides a structured way to understand attacker behavior and design security detections.

---

# Why Use MITRE ATT&CK

MITRE ATT&CK helps security teams:

- understand attacker tactics
- map detections to real-world techniques
- identify detection gaps
- standardize threat analysis
- communicate detection coverage

Using a common framework allows detection strategies to be aligned with industry practices.

---

# ATT&CK Structure

The framework is organized into two main components:

## Tactics

Tactics represent **the adversary’s objective**.

Examples include:

- Initial Access
- Execution
- Persistence
- Privilege Escalation
- Credential Access
- Discovery
- Lateral Movement
- Command and Control

## Techniques

Techniques describe **how attackers achieve those objectives**.

Example:

Execution tactic may include techniques such as command-line execution or script execution.

---

# MITRE ATT&CK in This Lab

Detection experiments in this lab are mapped to MITRE ATT&CK techniques.

Example mapping:

| Technique | Description | Example Detection |
|----------|-------------|------------------|
| T1059 | Command-line execution | suspicious shell commands |
| T1547 | Persistence | startup item monitoring |
| T1003 | Credential access | suspicious memory access |
| T1046 | Network discovery | unusual network scanning |

Mapping detections to ATT&CK allows the lab to simulate realistic SOC workflows.

---

# Detection Coverage

One goal of this lab is to understand **which techniques can be detected using endpoint telemetry**.

By mapping telemetry signals to MITRE ATT&CK techniques, we can evaluate:

- detection coverage
- visibility gaps
- opportunities for improved telemetry

---

# ATT&CK and Detection Engineering

MITRE ATT&CK plays a key role in modern detection engineering by helping teams:

- design behavior-based detections
- prioritize detection development
- simulate adversary techniques
- measure detection maturity

This lab uses MITRE ATT&CK as a reference model for building and testing detections.

---

# Future ATT&CK Experiments

Future experiments may include:

- simulating attacker techniques
- testing detection coverage
- creating ATT&CK-aligned detection rules
- evaluating telemetry visibility
