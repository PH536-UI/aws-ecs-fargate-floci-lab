variable "aws_region" {
  description = "AWS region label used by the local emulator."
  type        = string
  default     = "us-east-1"
}

variable "floci_endpoint" {
  description = "Floci-compatible AWS API endpoint. Keep localhost for the local lab."
  type        = string
  default     = "http://localhost:4566"
}

variable "project_name" {
  description = "Prefix for local resources."
  type        = string
  default     = "ph-ecs-fargate-lab"
}

variable "image_tag" {
  description = "Image tag deployed to the ECS task."
  type        = string
  default     = "v1"
}

variable "deploy_application" {
  description = "False creates foundation only. Set true after building and pushing the local ECR image."
  type        = bool
  default     = false
}
