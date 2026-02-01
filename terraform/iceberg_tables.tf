resource "aws_glue_catalog_table" "sample_iceberg_table" {
  name          = "sample_events"
  database_name = "iceberg-lakehouse_dev_lakehouse"
  table_type    = "ICEBERG"

  parameters = {
    "table_type"     = "ICEBERG"
    "classification" = "iceberg"
    "EXTERNAL"       = "TRUE"
  }

  storage_descriptor {
    location      = "s3://iceberg-lakehouse-dev-curated/iceberg/sample_events/"
    input_format  = "org.apache.hadoop.mapred.FileInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"

    columns {
      name = "event_id"
      type = "string"
    }

    columns {
      name = "event_type"
      type = "string"
    }

    columns {
      name = "event_timestamp"
      type = "timestamp"
    }
  }
}

