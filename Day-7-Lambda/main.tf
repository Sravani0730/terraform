resource "aws_lambda_function" "my_lambda" {
  function_name = "my-lambda-function"
  role          = "arn:aws:iam::609588777305:role/lambda-rds"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"  
  timeout       = 900
  memory_size   = 128

  filename      = "lambda_function.zip" 
  source_code_hash = filebase64sha256("lambda_function.zip")
}