output "floci_endpoint" {
  value       = var.floci_endpoint
  description = "Local AWS-compatible endpoint used by this lab."
}

output "ecr_repository_url" {
  value       = aws_ecr_repository.app.repository_url
  description = "Local ECR-compatible URI. Build and push the image here before deployment."
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.main.name
  description = "ECS cluster name."
}

output "service_name" {
  value       = var.deploy_application ? aws_ecs_service.app[0].name : null
  description = "Created only when deploy_application=true."
}
