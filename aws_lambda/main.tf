provider "aws" {
  region = "us-west-2"
}

module "lambda" {
  source  = "clouddrove/lambda/aws"
  version = "0.12.2"

  name        = "foo"
  application = "app"
  environment = "test"
  label_order = ["application", "name", "environment"]
  enabled     = true
  filename    = "${path.module}/lambda"
  handler     = "lambda.handler"
  runtime     = "nodejs12.x"
  variables = {
    foo = "bar"
  }
}
