resource "aws_iam_role" "lambda_role" {
  name = var.lambda_role_name

  assume_role_policy = jsonencode({
     Version = "2012-10-17"
     Statement = [{
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
        Service = "lambda.amazonaws.com"
      }
     }]
  })
}


resource "aws_iam_role_policy_attachment" "dynamodb_policy" {
   role = aws_iam_role.lambda_role.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_role_policy_attachment" "ses_policy" {
   role = aws_iam_role.lambda_role.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
}

resource "aws_iam_role_policy_attachment" "sns_policy" {
   role = aws_iam_role.lambda_role.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}


resource "aws_iam_role_policy_attachment" "cloudwatch_policy" {
   role = aws_iam_role.lambda_role.name
   policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}


resource "aws_lambda_function" "reminder_lambda" {
  for_each = toset(var.lambda_functions_name)

  function_name = each.key
  runtime       = var.lambda_runtime
  handler       = var.lambda_handler
  role          = aws_iam_role.lambda_role.arn

  # Use element to map index to zip file path
  filename         = element(var.zip_file_path, index(var.lambda_functions_name, each.key))
  source_code_hash = filebase64sha256(element(var.zip_file_path, index(var.lambda_functions_name, each.key)))

  # Apply the layer only to the first lambda function
  layers = each.key == var.lambda_functions_name[0] ? [var.layer_arn] : []
}



resource "aws_lambda_event_source_mapping" "dynamodb_trigger" {
   event_source_arn  = var.dynamodb_table_stream_arn
   function_name     = aws_lambda_function.reminder_lambda[var.lambda_functions_name[2]].arn
   starting_position = "LATEST"
}

