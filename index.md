---
date: 2025-12-06
title: Building CIS EKS Compliance Automation with Kyverno and OpenTofu
linkTitle: Building CIS EKS Compliance Automation with Kyverno and OpenTofu
author: Yug
description: A practical approach to implementing CIS security controls using CNCF cloud native tools.
---

# Building CIS EKS Compliance Automation with Kyverno and OpenTofu

*A practical approach to implementing CIS security controls using CNCF cloud native tools*

---

## Introduction: The Challenge of EKS Compliance at Scale

Maintaining CIS Amazon EKS Benchmark compliance across multiple clusters is a common challenge in cloud native environments. Traditional manual approaches don't scale, and existing solutions often lack comprehensive coverage or real-time enforcement capabilities.

This article explores a practical approach to automating CIS EKS compliance using:

- **Kyverno** – a CNCF Incubating project for Kubernetes-native policy management
- **OpenTofu** – for infrastructure provisioning and validation
- **kube-bench** – for node-level CIS scanning

This solution demonstrates how CNCF ecosystem tools can work together to provide **comprehensive security validation** across the entire infrastructure and application stack.

The open source project **[`cis-eks-kyverno`](https://github.com/ATIC-Yugandhar/cis-eks-kyverno)** implements **62+ CIS controls** with a multi-tool plan-time and runtime validation strategy, comprehensive testing, and automated reporting. This framework showcases **cloud native security automation** and has been tested extensively with **KIND (Kubernetes in Docker)** clusters.

---

## The Compliance Challenge in Cloud Native Environments

The **CIS Amazon EKS Benchmark v1.7.0** contains **46 security recommendations** across five critical areas:

- **Control Plane Configuration (Section 2):** Audit logging, endpoint security — *2 controls*
- **Worker Node Security (Section 3):** Kubelet configuration, file permissions — *13 controls*
- **RBAC & Service Accounts (Section 4):** Access controls, service account security — *15 controls*
- **Pod Security Standards (Section 5):** Container runtime security — *9 controls*
- **Managed Services (Section 5):** ECR, networking, encryption — *7 additional controls*

### Traditional Compliance Approaches

1. Manual `kubectl` commands for configuration checks  
2. SSH access to worker nodes for file permission audits  
3. Periodic reviews of infrastructure configurations  
4. Manual report generation for security assessments  
5. Reactive remediation after issues are discovered  

### Challenges with Manual Approaches

-  **Scale limitations:** Manual processes don't scale across multiple Kubernetes clusters  
-  **Time-intensive:** Comprehensive audits can take days per cluster  
-  **Error-prone:** Human oversight can miss critical security configurations  
-  **Reactive:** Issues discovered weeks after deployment  
-  **Inconsistent:** Different teams may interpret controls differently  
-  **Cloud native complexity:** Traditional tools don't understand Kubernetes-native resources  

---

## The Cloud Native Opportunity

Modern **CNCF ecosystem tooling** offers the potential to:

- Automate most compliance checks  
- Shift security left into the development process  
- Provide **continuous monitoring**

The key is leveraging **cloud native technologies** that work well together and understand Kubernetes-specific patterns.

---

## The Multi-Tool Cloud Native Approach to Complete CIS Coverage

No single tool can validate all CIS controls due to their diverse nature. This implementation combines the strengths of multiple CNCF tools:

-  **Kyverno** (CNCF Incubating): Kubernetes-native policy engine for runtime validation  
-  **kube-bench:** Community-standard CIS compliance scanner for node-level validation  
-  **OpenTofu:** Open-source infrastructure-as-code for plan-time validation  
-  **Kind:** CNCF-aligned local Kubernetes testing  

---

## Solution: Hybrid Cloud Native Policy Automation Architecture

The framework implements a **multi-layered approach**, combining the strengths of different CNCF and cloud native security tools:

![architecture-cis](./arch-cis.png)


---

### 1. Plan-Time Validation (Shift-Left Security)
-  Validates **OpenTofu** configurations before deployment  
-  Catches misconfigurations early in development  
-  Policies located in: `policies/opentofu/`

---

### 2. Runtime Validation (Continuous Monitoring)
-  **Kyverno** – CNCF Incubating project for Kubernetes resource validation  
-  Coverage includes:  
  - Pod Security Standards  
  - RBAC  
  - Service Accounts  
  - Network Policies

---

### 3. Node-Level Validation (Deep System Inspection)
-  **kube-bench** – Industry-standard CIS compliance scanner with privileged access  
-  Coverage includes:  
  - File permissions  
  - Kubelet configuration  
  - Control plane settings

---

## Implementation: Complete Multi-Layer Security Pipeline

###  Step 1: Infrastructure Creation with OpenTofu

This open-source project implements a **comprehensive security validation pipeline** that spans the entire infrastructure and application lifecycle:

-  **Plan-time validation** with OpenTofu  
-  **Runtime policy enforcement** with Kyverno  
-  **System-level auditing** with kube-bench  

>  **Note:** This implementation has been thoroughly tested using **KIND** clusters and is available for community experimentation and contribution.

 **File Reference:**  
`opentofu/compliant/main.tf`
```yaml
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = aws_subnet.private[*].id
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  encryption_config {
    resources = ["secrets"]
    provider {
      key_arn = aws_kms_key.eks.arn
    }
  }
  
  tags = {
    Environment = "production"
    Owner       = "platform-team"
  }
}
```

