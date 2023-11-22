output "access_key" {
  value = aws_iam_access_key.IAMUser.id
}

output "secret_key" {
  value = aws_iam_access_key.IAMUser.secret
  sensitive = true
}
output "repository_url_deepsine_lambda_ecr" {
  value = aws_ecr_repository.ECRRepository2.repository_url
}
output "repository_url_ineference_pipeline_daisy_ecr" {
  value = aws_ecr_repository.ECRRepository.repository_url
}