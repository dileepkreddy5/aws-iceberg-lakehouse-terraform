resource "aws_glue_catalog_database" "lakehouse_db" {
  name = "${var.project_name}_${var.environment}_lakehouse"

  description = "Glue catalog database for Iceberg-based lakehouse tables"
}

