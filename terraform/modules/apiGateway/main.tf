resource "aws_apigatewayv2_api" "reminder_api" {
    name = var.api_name
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "set_reminder" {
   api_id = aws_apigatewayv2_api.reminder_api.id
   integration_type = "AWS_PROXY"
   integration_uri = var.set_reminder_lambda_arn
}

resource "aws_apigatewayv2_route" "post_setreminder" {
   api_id = aws_apigatewayv2_api.reminder_api.id
   route_key = "POST /setreminder"
   target = "integrations/${aws_apigatewayv2_integration.set_reminder.id}"
}

resource "aws_apigatewayv2_integration" "get_reminder" {
   api_id = aws_apigatewayv2_api.reminder_api.id
   integration_type = "AWS_PROXY"
   integration_uri = var.get_reminder_lambda_arn
}

resource "aws_apigatewayv2_route" "get_getreminder" {
   api_id = aws_apigatewayv2_api.reminder_api.id
   route_key = "GET /getreminder"
   target = "integrations/${aws_apigatewayv2_integration.get_reminder.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
   api_id = aws_apigatewayv2_api.reminder_api.id
   name = "$default"
   auto_deploy = true
}

resource "aws_lambda_permission" "allow_api_gateway_post" {
  action = "lambda:InvokeFunction"
  function_name = var.set_reminder_lambda_arn
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.reminder_api.execution_arn}/*"
}

resource "aws_lambda_permission" "allow_api_gateway_get" {
    action = "lambda:InvokeFunction"
    function_name = var.get_reminder_lambda_arn
    principal     = "apigateway.amazonaws.com"
    source_arn    = "${aws_apigatewayv2_api.reminder_api.execution_arn}/*"
}
