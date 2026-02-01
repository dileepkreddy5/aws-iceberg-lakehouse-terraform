locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy  = "Terraform"
  }
}

module "s3_lakehouse" {
  source       = "../modules/s3-lakehouse"
  project_name = var.project_name
  environment  = var.environment
  tags         = local.common_tags
}

module "glue_catalog" {
  source       = "../modules/glue-catalog"

  project_name = var.project_name
  environment  = var.environment

  providers = {
    aws = aws
  }
}

