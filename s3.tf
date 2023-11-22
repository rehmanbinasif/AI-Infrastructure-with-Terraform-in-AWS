resource "aws_s3_bucket" "S3Bucket" {
    bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_versioning" "S3BucketVersioning" {
  bucket = aws_s3_bucket.S3Bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_cors_configuration" "S3BucketCors" {
  bucket = aws_s3_bucket.S3Bucket.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "S3BucketLifecycle" {
  bucket = aws_s3_bucket.S3Bucket.bucket

  rule {
    id      = "Delete versions"
    status  = "Enabled"

    abort_incomplete_multipart_upload {
      days_after_initiation = 1
    }

    noncurrent_version_transition {
      noncurrent_days = 1
      storage_class = "GLACIER"
    }

    expiration {
      days = 1
    }
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "S3BucketSSE" {
  bucket = aws_s3_bucket.S3Bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_public_access_block" "S3BucketPublicAccessBlock" {
  bucket = aws_s3_bucket.S3Bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.S3Bucket.bucket

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.LambdaFunction2.arn}"
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "cases_input/"
    filter_suffix       = ".zip"
  }

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.LambdaFunction.arn}"
    events              = ["s3:ObjectCreated:Post"]
    filter_prefix       = "xrays_input/"
    filter_suffix       = ".zip"
  }

  lambda_function {
    lambda_function_arn = "${aws_lambda_function.LambdaFunction.arn}"
    events              = ["s3:ObjectCreated:Copy"]
    filter_prefix       = "xrays_input/"
    filter_suffix       = ".zip"
  }
  depends_on = [aws_lambda_function.LambdaFunction2]
}