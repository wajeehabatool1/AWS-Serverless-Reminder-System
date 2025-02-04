output "set_reminder_lambda_arn" {
  value = aws_lambda_function.reminder_lambda[var.lambda_functions_name[0]].arn
}

output "get_reminder_lambda_arn" {
   value = aws_lambda_function.reminder_lambda[var.lambda_functions_name[1]].arn
}


