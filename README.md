# Multi-Environment Infrastructure Design using Terraform

##  Project Overview

This project demonstrates how to provision and manage a multi-environment AWS infrastructure using Terraform.

The infrastructure includes:

- VPC
- EC2 Instance
- Security Groups
- S3 Bucket (Application Storage)
- Remote Backend using S3
- Environment Isolation using Workspaces
- Modular Terraform Architecture

Environments:

- Dev → Small instance
- Staging → Medium instance
- Production → Large instance + Extra security rules

---
# Project Architecture Diagram
![Architecture](images/architecture.jpeg)
---

#  Project Structure

```
Terraform-Multi-Environment-Infrastructure/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── backend.tf
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── s3/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── env/
    ├── dev.tfvars
    ├── staging.tfvars
    └── prod.tfvars
```

---

#  Technologies Used

- Terraform
- Amazon EC2
- Amazon VPC
- Amazon S3

---

#  Workspace Strategy

Separate Terraform workspaces are used for each environment:

```
 dev
 staging
 prod
```

Each workspace maintains:

- Separate state file
- Separate infrastructure
- Proper isolation

---

#  Remote Backend Setup

State is stored in S3:

```
terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket-akshay"
    key     = "multi-env/${terraform.workspace}/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}
```

Benefits:

- Remote state management
- Safe collaboration
- Environment isolation
- Production safety

---

#  Infrastructure Differences Per Environment

| Environment | EC2 Type | Security Rules |
|------------|----------|----------------|
| Dev | t2.micro | HTTP + SSH |
| Staging | t2.small | HTTP + SSH |
| Production | t2.medium | HTTP + Restricted SSH |

---
##  Resource Tagging

All resources are tagged:

```
tags = {
  Environment = var.environment
}
```

Helps in cost tracking and environment identification.

---

#  Deployment Steps

## Step 1: Initialize Terraform

```
terraform init
```
![ Initialize](images/initialize.png)

## Step 2: Create Workspaces

```
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod
```
![ Workspaces](images/workspaces.png)

## Step 3: Deploy Dev

```
terraform workspace select dev
terraform plan -var-file="env/dev.tfvars"
terraform apply -var-file="env/dev.tfvars"
```
#### **plan:**
![ plan](images/dev-plan.png)
#### **Apply:**
![ Apply](images/dev-apply.png)

## Step 4: Deploy Staging

```
terraform workspace select staging
terraform plan -var-file="env/staging.tfvars"
terraform apply -var-file="env/staging.tfvars"
```
#### **plan:**
![ plan](images/staging-plan.png)
#### **Apply:**
![ Apply](images/staging-apply.png)

## Step 5: Deploy Production

```
terraform workspace select prod
terraform plan -var-file="env/prod.tfvars"
terraform apply -var-file="env/prod.tfvars"
```
#### **plan:**
![ plan](images/prod-plan.png)
#### **Apply:**
![ Apply](images/prod-apply.png)

## step 6: Destroy Environment
#### **Dev:**
```
terraform workspace select dev
terraform destroy -var-file="env/dev.tfvars"
```
#### **Staging:**
```
terraform workspace select staging
terraform destroy -var-file="env/staging.tfvars"
```
#### **Prod:**
```
terraform workspace select prod
terraform destroy -var-file="env/prod.tfvars"
```
---

#  Environment Validation

Isolation verified by:

- Different EC2 instance types
- Separate state files in S3
- Environment-based tags
- Destroying one workspace does not affect others

---

#  Screenshots

> Save all screenshots inside the `images/` folder.

## 1️. Workspace List

![Workspace List](images/workspacelist.png)

## 2. Ec2 instances
![ EC2](images/ec2.png)

####  **Dev Environment (EC2)**

![Dev EC2](images/dev-ec2.png)

####  **Staging Environment (EC2)**

![Staging EC2](images/staging-ec2.png)

####  **Production Environment (EC2)**

![Production EC2](images/prod-ec2.png)

## 3. Security Groups
#### **Dev:**
![Dev SG](images/dev-sg.png)
#### **Staging:**
![Staging SG](images/staging-sg.png)
#### **prod:**
![Prod SG](images/prod-sg.png)

## 4. Vpc's
![Vpc's](images/vpc.png)

## 5. S3 App Buckets
![S3 App Buckets](images/s3-app-bucket.png)

## 6. S3 Remote State Files Bucket

![S3 State Files Bucket](images/s3-statefile-bucket.png)

```
terraform-state-bucket-akshay
└── env/
    ├── dev/
    │   └── multi-env/
    │       └── terraform.tfstate
    ├── staging/
    │   └── multi-env/
    │       └── terraform.tfstate
    └── prod/
        └── multi-env/
            └── terraform.tfstate

```
#### **Dev:**
![S3 State Files Dev](images/dev-tfstate.png)

#### **Staging:**
![S3 State Files Staging](images/staging-tfstate.png)

#### **Prod:**
![S3 State Files Prod](images/prod-tfstate.png)

---

#  Deliverables

- Modular Terraform Code
- Workspace Setup Proof
- Screenshots of 3 Environments
- Remote Backend Configuration
- Environment Isolation Demonstration
- Production Safety Configuration

---

#  Key Learning Outcomes

- Modular Infrastructure Design
- Multi-Environment Strategy
- Terraform Workspaces
- Remote Backend Configuration
- Production-Level Safety Practices
- Infrastructure Isolation

---

#  Conclusion

This project demonstrates a scalable and production-ready Terraform architecture with:

- Clean modular design
- Secure remote state management
- Environment isolation
- Production protection
---
## Author: 
#### Akshay Jagtap