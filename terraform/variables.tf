variable "region" {
  description = "Región AWS"
  type        = string
  default     = "us-west-1"
}

variable "lambda_role_arn" {
  description = "ARN del rol IAM para Lambda"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  type        = string
  default     = "Users"
}
