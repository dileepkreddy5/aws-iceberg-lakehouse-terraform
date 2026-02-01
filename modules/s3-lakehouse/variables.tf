variable "project_name" {
  type        = string
  description = "Project name used for bucket naming"
}

variable "environment" {
  type        = string
  description = "Deployment environment"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
}

