terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "dynamodb" {
  source = "./modules/dynamodb"
  table_name = var.table_name
  ttl_attribute = var.billing_mode
  billing_mode = var.billing_mode
}

module "lambda" {
  source = "./modules/lambda"
  lambda_role_name  = var.lambda_role_name
  lambda_functions_name = var.lambda_functions_name
  lambda_runtime = var.lambda_runtime
  lambda_handler = var.lambda_handler
  zip_file_path = var.zip_file_path
  layer_arn = var.layer_arn
  dynamodb_table_stream_arn = module.dynamodb.dynamodb_table_stream_arn

  depends_on = [module.dynamodb]
}

module "apiGateway" {
  source = "./modules/apiGateway"
  set_reminder_lambda_arn =  module.lambda.set_reminder_lambda_arn
  get_reminder_lambda_arn = module.lambda.get_reminder_lambda_arn

}