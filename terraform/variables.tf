variable "aws_region" {
  description = "AWS region where the lakehouse infrastructure will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Logical name for the lakehouse project"
  type        = string
  default     = "iceberg-lakehouse"
}

variable "environment" {
  description = "Deployment environment (dev, stage, prod)"
  type        = string
  default     = "dev"
}

