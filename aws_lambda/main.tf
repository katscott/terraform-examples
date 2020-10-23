provider "aws" {
  region                      = "us-west-2"
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    apigateway     = "http://localhost:4567"
    cloudformation = "http://localhost:4581"
    cloudwatch     = "http://localhost:4582"
    dynamodb       = "http://localhost:4569"
    es             = "http://localhost:4578"
    firehose       = "http://localhost:4573"
    iam            = "http://localhost:4593"
    kinesis        = "http://localhost:4568"
    lambda         = "http://localhost:4574"
    route53        = "http://localhost:4580"
    redshift       = "http://localhost:4577"
    s3             = "http://localhost:4572"
    secretsmanager = "http://localhost:4584"
    ses            = "http://localhost:4579"
    sns            = "http://localhost:4575"
    sqs            = "http://localhost:4576"
    ssm            = "http://localhost:4583"
    stepfunctions  = "http://localhost:4585"
    sts            = "http://localhost:4592"
    ec2            = "http://localhost:4597"
  }
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
