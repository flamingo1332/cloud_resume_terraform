resource "aws_cloudwatch_metric_alarm" "lambda_error" {
  alarm_name          = var.cloudwatch_alarm_lambda_error_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 86400  # 24 hours
  statistic           = "Average"
  threshold           = 5
  alarm_description   = "Alarm triggered when Lambda errors are greater than 5"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
  FunctionArn = var.lambda_visitor_arn
}
}

resource "aws_cloudwatch_metric_alarm" "lambda_invocation" {
  alarm_name          = var.cloudwatch_alarm_lambda_invocation_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Invocations"
  namespace           = "AWS/Lambda"
  period              = 86400  # 24 hours
  statistic           = "Average"
  threshold           = 5
  alarm_description   = "Alarm triggered when Lambda invocations are greater than 5"
  alarm_actions       = [var.sns_topic_arn]
  dimensions = {
  FunctionArn = var.lambda_visitor_arn
}
}

resource "aws_cloudwatch_metric_alarm" "APIgateway_latency" {
  alarm_name          = var.cloudwatch_alarm_apigateway_latency_name
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  # metric_name         = "Latency"
  # namespace           = "AWS/ApiGateway"
  # period              = 86400  # 24 hours
  # statistic           = "Average"
  threshold           = 5
  alarm_description   = "Alarm triggered when API Gateway latency is greater than 5"
  alarm_actions       = [var.sns_topic_arn]

  metric_query {
    id        = "m1"
    metric {
      metric_name = "Latency"
      period = 86400
      stat = "Average"
      namespace           = "AWS/ApiGateway"
      dimensions = {
        ApiGateway = var.apigateway_arn
      }
    }
    return_data = true
  }

}
