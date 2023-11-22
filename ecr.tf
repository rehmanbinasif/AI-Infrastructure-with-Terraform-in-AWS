resource "aws_ecr_repository" "ECRRepository" {
    name = "ineference-pipeline-daisy-ecr"
}

resource "aws_ecr_repository" "ECRRepository2" {
    name = "deepsine-lambda-ecr"
}