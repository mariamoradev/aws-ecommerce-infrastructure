provider "aws" {
  region = "us-west-1" # Puedes cambiar esto a tu región activa si es diferente
}

# 1. Política para permitir que Lambda asuma el rol
data "aws_iam_policy_document" "assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# 2. Rol IAM para Lambda
resource "aws_iam_role" "lambda_exec" {
  name               = "lambda_exec_role"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

# 3. Política de permisos para Lambda (logs y DynamoDB)
resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "dynamodb:*"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# 4. Función Lambda empaquetada (asegúrate de tener user.zip listo)
resource "aws_lambda_function" "user_register" {
  filename         = "../terraform/user.zip"
  function_name    = "user-register"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "register.handler" # register.js → export const handler = ...
  runtime          = "nodejs16.x"
}

# 5. Tabla DynamoDB "Users"
resource "aws_dynamodb_table" "users" {
  name           = "Users"
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "uuid"
  range_key      = "email"

  attribute {
    name = "uuid"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }
}




