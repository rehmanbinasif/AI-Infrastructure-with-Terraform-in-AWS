variable "generic_user" {
  description = "The name of the generic user"
  type        = string
  default     = "daisy" 
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "carlsmed-daisy-server-bucket-vnv" 
}


variable "region" {
  description = "The name of the region"
  type        = string
  default     = "us-west-2" 
}

variable "dicom_image_tag" {
  description = "The image tag name of the dicom container lambda"
  type        = string
  default     = "latest" 
}

variable "daisy_xray_message_handler_image_tag" {
  description = "The image tag name of the daisy xray message handler lambda"
  type        = string
  default     = "converter131023" 
}


variable "managed_policy_arns_vnv" {
  description = "List of managed policy ARNs to attach to the IAM group"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemFullAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaRole",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AWSLambda_FullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonS3ObjectLambdaExecutionRolePolicy"
  ]
}