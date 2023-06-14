# Terraform AWS WordPress

This repository contains Terraform configurations for provisioning a 3-tier architecture on AWS to host a WordPress application.

## TABLE OF CONTENTS

-  [Overview](#overview)
-  [Prerequisites](#prerequisites)
-  [AWS Services](#aws-services)
-  [Architecture](#architecture)
-  [Usage](#usage)
-  [Managing WordPress](#managing-wordpress)

## Overview

This repository contains Terraform configurations for provisioning a 3-tier architecture on AWS to host a WordPress application. The 3-tier architecture consists of a web layer, an application layer, and a database layer, providing a scalable and highly available infrastructure for hosting the WordPress application. By using the Terraform configurations in this repository, you will be able to set up the necessary infrastructure on AWS and deploy the WordPress application

## Prerequisites

Before using the Terraform configurations in this repository, make sure you have the following:

-  An AWS account
-  Terraform installed

## AWS Services

This project uses several AWS services to provision the infrastructure for hosting a WordPress application using a 3-tier architecture. The following AWS services are used:

-  **Amazon VPC**: Used to create a virtual private cloud (VPC) for the infrastructure.
-  **Amazon EC2**: Used to launch EC2 instances for the web and application layers.
-  **Amazon RDS**: Used to create an RDS instance for the database layer.
-  **Amazon EFS** Used to create an Elastic File System (EFS) for storing WordPress files.
-  **Amazon ALB** Used to create an Application Load Balancer (ALB) for distributing traffic between the web and application layers.
-  **Amazon CloudWatch** Used to monitor the infrastructure and collect logs and metrics.

## Architecture

The 3-tier architecture used in this project consists of a web layer, an application layer, and a database layer.
The infrastructure is provisioned using Terraform and consists of several components, including a VPC, subnets, security groups, EC2 instances, an RDS instance, an EFS file system, and an ALB. These components are configured to work together to provide a scalable and highly available infrastructure for hosting the WordPress application.

![last (1)](https://github.com/sm0483/wordpress-infra/assets/74458527/1516a515-5bfa-469a-8dc9-5cbdacce98b6)

## Usage

To use the Terraform configurations in this repository to provision the infrastructure on AWS, follow these steps:

1. Clone this repository: `git clonegit@github.com:sm0483/wp-3tier-aws.git`
2. Navigate to the project directory: `cd wp-3tier-aws/src/infrastructure/`
3. Initialize Terraform: `terraform init`
4. Create a `terraform.tfvars` file with your AWS credentials and other required variables.

```
my_ip  = ""
region = ""
zone_one = ""
zone_two = ""
```

5. Plan the Terraform changes: `terraform plan`
6. Apply the Terraform changes: `terraform apply`


## Managing WordPress

Once your WordPress site is up and running, you can manage it by logging in to the WordPress admin dashboard using your admin credentials. From there, you can create new posts and pages, manage users, install plugins and themes, and customize your site.
