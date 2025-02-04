region = "ap-south-1"
table_name = "reminderTable"
billing_mode = "PAY_PER_REQUEST"
ttl_attribute = "ttl"

lambda_functions_name = [
  "setReminderLambda1",
  "getReminderLambda2",
  "sentReminderLambda3"
]

lambda_runtime = "python3.13"

lambda_handler = "app.lambda_handler"

zip_file_path = [
  "C:/Users/Administrator/Desktop/reminderSystem/terraform/modules/lambda/setReminder.zip",
  "C:/Users/Administrator/Desktop/reminderSystem/terraform/modules/lambda/getReminder.zip",
  "C:/Users/Administrator/Desktop/reminderSystem/terraform/modules/lambda/sendReminder.zip"
]

lambda_role_name = "reminderSystemLambdaRole"

layer_arn = "arn:aws:lambda:ap-south-1:339712865909:layer:pytz-layer:1"

