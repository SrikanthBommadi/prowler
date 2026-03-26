# 🔐 Prowler - Cloud Security & Compliance Scanning

## 🚀 Overview
Prowler is an open-source security tool used for **cloud security assessments, auditing, and compliance checks** across AWS, Azure, and GCP environments.

It helps identify misconfigurations and security risks based on industry standards such as:
- CIS Benchmarks
- GDPR
- HIPAA
- ISO 27001
- SOC2

---

## 🧠 How Prowler Works (Real Workflow)

### 🔄 End-to-End Flow

Cloud Account → Authentication → Scan Execution → Security Checks → Findings → Reports → Remediation

---

## 📌 Workflow Breakdown

### 1. Authentication
Prowler connects to your cloud account using:
- IAM Roles (recommended for production)
- Access Keys (for local/dev testing)

---

### 2. Resource Discovery
Prowler scans cloud services like:
- EC2
- S3
- IAM
- RDS
- CloudTrail

---

### 3. Security Checks Execution
Runs hundreds of built-in checks such as:
- S3 bucket public access
- MFA enabled for root account
- Open security groups (0.0.0.0/0)

---

### 4. Results Classification
Each check result is categorized as:
- PASS ✅
- FAIL ❌
- INFO ℹ️

---

### 5. Report Generation
Outputs available in:
- JSON
- CSV
- HTML (recommended for dashboards)

---

### 6. Remediation
Issues can be fixed via:
- Manual updates
- Terraform / Infrastructure as Code
- CI/CD automation

---

## 🏗️ Architecture
