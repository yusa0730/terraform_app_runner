# lambda_functionディレクトリで以下のコマンドを実行してlambdaのコードを最新化する
# pip install -r requirements.txt -t .
# zip -r ../lambda_function_payload.zip .
# Lambda function
resource "aws_lambda_function" "main" {
  function_name = var.lambda_function_name
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.7"
  role          = aws_iam_role.lambda_role.arn
  filename      = "./lambda_function_payload.zip"

  vpc_config {
    security_group_ids = [
      aws_security_group.from_api_gateway_to_lambda_sg.id
    ]
    subnet_ids = [
      aws_subnet.lambda_private_a.id,
      aws_subnet.lambda_private_c.id
    ]
  }
}
