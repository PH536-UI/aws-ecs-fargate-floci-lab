provider "aws" {
  region     = var.aws_region
  access_key = "test"
  secret_key = "test"

  # This provider is deliberately bound to Floci, never to an AWS account.
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  skip_region_validation      = true

  endpoints {
    ec2            = var.floci_endpoint
    ecr            = var.floci_endpoint
    ecs            = var.floci_endpoint
    iam            = var.floci_endpoint
    cloudwatchlogs = var.floci_endpoint
    sts            = var.floci_endpoint
  }
}
