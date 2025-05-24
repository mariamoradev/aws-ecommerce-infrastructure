output "lambda_function_name" {
  description = "Nombre de la función Lambda creada"
  value       = aws_lambda_function.user_register.function_name
}

output "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  value       = aws_dynamodb_table.users.name
}
