# Implementing a Transactional Data Lakehouse with Apache Iceberg and Terraform

## Overview

In this project, I built a transactional data lakehouse on AWS using **Apache Iceberg** and **Terraform**.

The goal was simple: design a storage layer that works well for analytics today, but is also flexible enough to support machine learning and GenAI workloads tomorrow — without locking into a single vendor or running expensive always-on infrastructure.

This is not a demo project. It’s structured the way I would build the foundation of a real data platform in an enterprise environment.

---

## High-Level Architecture

At a high level, the platform consists of:

- **Amazon S3** as the primary storage layer  
- **Apache Iceberg** to manage tables with transactions, schema evolution, and versioning  
- **AWS Glue Data Catalog** to store table metadata  
- **Amazon Athena** for serverless SQL querying  
- **Terraform** to provision and manage all infrastructure  
- **IAM and KMS** for security and encryption  
- **AWS Budgets** to keep costs under control  

The architecture diagram (in the `diagrams/` folder) shows how these components fit together.

---

## Why I Chose Apache Iceberg

I chose **Apache Iceberg** instead of formats like Delta Lake or plain Parquet for a few reasons:

- I wanted an **open table format** that doesn’t lock me into a specific vendor or platform.
- Iceberg works well with multiple engines (Athena today, Spark or Trino later).
- It supports **ACID transactions**, which makes concurrent reads and writes safer.
- Schema changes don’t require rewriting entire datasets.
- Built-in **time travel** makes it easier to debug issues or roll back bad data.

For modern analytics and AI-driven use cases, these features matter a lot more than just storing files in S3.

---

## Why Amazon Athena

Athena was a deliberate choice for the first version of this platform.

- It’s serverless, so there’s no cluster to manage or pay for when idle.
- You only pay for the queries you run.
- It integrates cleanly with Iceberg and Glue.
- It’s a good fit for ad-hoc analysis, BI queries, and feature extraction.

If the workload later requires heavier transformations, this setup can be extended with Spark or EMR without changing the underlying storage design.

---

## Why Terraform

All infrastructure in this project is provisioned using **Terraform**.

This makes the setup:
- Reproducible
- Auditable
- Easy to tear down when not in use
- Consistent across environments

It also reflects how I manage cloud infrastructure in real projects — not through the console, but through version-controlled code.

---

## Data Layout

The lakehouse follows a simple and practical zone-based layout:

- **Raw zone**  
  Stores incoming data in its original form. This layer is immutable and acts as the source of truth.

- **Curated zone**  
  Cleaned and validated datasets managed as Iceberg tables.

- **Analytics zone**  
  Query-optimized Iceberg tables used for reporting, ML feature generation, and downstream applications.

Each Iceberg table is versioned and partitioned to support efficient querying and safe updates.

---

## Terraform Structure

Terraform code is split into focused modules, each with a clear responsibility:

- `s3-lakehouse` – creates storage buckets and lifecycle policies  
- `glue-catalog` – manages Iceberg table metadata  
- `iam` – defines least-privilege roles and policies  
- `kms` – handles encryption keys  
- `athena` – configures workgroups and query limits  
- `budgets` – enforces cost controls  

This modular approach mirrors how production cloud platforms are typically organized.

---

## Cost Management

Cost control was a design requirement from the beginning.

To avoid surprise bills:
- AWS Budgets are configured with alerts
- Athena workgroups limit query spending
- S3 lifecycle rules move older data to cheaper storage tiers
- No long-running compute resources are used

The idea is to keep the platform predictable and affordable while still being scalable.

---

## Security and Governance

Security is built into the platform, not added later.

- All data is encrypted at rest using KMS
- IAM roles follow least-privilege principles
- No public access to S3 buckets or metadata
- Access to datasets is controlled at the catalog level

This design aligns well with regulated environments such as healthcare or government analytics platforms.

---

## What This Project Shows

This project demonstrates how to:

- Design a transactional lakehouse using open standards
- Use Infrastructure as Code for repeatable cloud deployments
- Balance scalability with cost control
- Build data foundations that are ready for analytics, ML, and GenAI
- Make clear architectural decisions and explain the trade-offs

---

## Possible Next Steps

Some natural extensions to this platform would be:
- Streaming ingestion into Iceberg tables
- Fine-grained access control with Lake Formation
- Feature store integration for ML workloads
- Cross-region replication for disaster recovery

