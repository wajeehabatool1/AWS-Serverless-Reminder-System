variable "lambda_functions_name" {
  description = "list of lambda function"
  type = list(string)
}

variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
  default     = "python3.8"
}

variable "lambda_handler" {
  description = "Lambda function handler"
  type        = string
}

variable "zip_file_path" {
  description = "Path to the zipped Lambda function code"
  type        = list(string)
}

variable "lambda_role_name" {
  description = "IAM role for Lambda"
  type        = string
  default     = "reminderSystemLambdaRole"
}

variable "layer_arn" {
  description = "ARN of the existing Lambda Layer"
  type        = string
}

variable "dynamodb_table_stream_arn" {
  description = "ARN of dynamodb table stream"
  type        = string
}






