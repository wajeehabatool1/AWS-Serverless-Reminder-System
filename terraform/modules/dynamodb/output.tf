output "dynamodb_table_arn" {
  value = aws_dynamodb_table.reminders.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.reminders.name
}

output "dynamodb_table_stream_arn" {
  value = aws_dynamodb_table.reminders.stream_arn
}