variable "api_name" {
  description = "name of the http api"
  type        = string
  default = "reminderSystemAPI"
}


variable "set_reminder_lambda_arn" {
  description = "ARN of the Set Reminder Lambda"
  type        = string
}

variable "get_reminder_lambda_arn" {
  description = "ARN of the Get Reminder Lambda"
  type        = string
}
