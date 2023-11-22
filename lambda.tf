resource "aws_lambda_function" "LambdaFunction" {
    description = ""
    environment {
        variables = {
            IAM_ROLE = "${aws_iam_role.IAMRole2.arn}"
            REGION_NAME = "${var.region}"
            INPUT_FOLDER = "xrays_input"
            OUTPUT_FOLDER = "xrays_output"
            ENDPOINT_URL = "https://sqs.${var.region}.amazonaws.com"
            QUEUE_URL = "${aws_sqs_queue.SQSQueue2.url}"
            BUCKET_NAME = "${aws_s3_bucket.S3Bucket.bucket}"
        }
    }
    function_name = "daisy-xray-message-handler"
    architectures = [
        "x86_64"
    ]
    image_uri = "${aws_ecr_repository.ECRRepository2.repository_url}:${var.daisy_xray_message_handler_image_tag}"
    package_type = "Image"
    memory_size = 128
    role = "${aws_iam_role.IAMRole.arn}"
    timeout = 300
    tracing_config {
        mode = "PassThrough"
    }
    ephemeral_storage {
      size = 512
    }
}

resource "aws_lambda_function" "LambdaFunction2" {
    description = ""
    environment {
        variables = {
            IAM_ROLE = "${aws_iam_role.IAMRole2.arn}"
            SQS_ENDPOINT_URL = "https://sqs.${var.region}.amazonaws.com"
            REGION_NAME = "${var.region}"
            EFS_PATH = "/tmp"
            INPUT_FOLDER = "cases_input"
            OUTPUT_FOLDER = "cases_output"
            HARDWARE_STL = "True"
            INPUT_LOCATION = "s3://${aws_s3_bucket.S3Bucket.bucket}/cases_output"
            QUEUE_URL = "${aws_sqs_queue.SQSQueue.url}"
            AWS_SERVER_SECRET_KEY = "${aws_iam_access_key.IAMUser.secret}"
            BUCKET_NAME = "${aws_s3_bucket.S3Bucket.bucket}"
            AWS_SERVER_PUBLIC_KEY = "${aws_iam_access_key.IAMUser.id}"
            SMART_STRING = "Do the things in Carlsmed Way!!!"
        }
    }
    function_name = "Dicom-container"
    architectures = [
        "x86_64"
    ]
    image_uri = "${aws_ecr_repository.ECRRepository2.repository_url}:${var.dicom_image_tag}"
    package_type = "Image"
    memory_size = 10240
    role = "${aws_iam_role.IAMRole.arn}"
    timeout = 900
    tracing_config {
        mode = "PassThrough"
    }
    vpc_config {
        subnet_ids = [
        "${aws_subnet.EC2Subnet.id}",
        "${aws_subnet.EC2Subnet2.id}",
        "${aws_subnet.EC2Subnet3.id}",
        "${aws_subnet.EC2Subnet4.id}"
        ]
        security_group_ids = [
        "${aws_security_group.EC2SecurityGroup2.id}",
        "${aws_security_group.EC2SecurityGroup4.id}",
        "${aws_security_group.EC2SecurityGroup.id}"
        ]
    }
    file_system_config {
      arn            = "${aws_efs_access_point.efs_access_point.arn}"
      local_mount_path = "/mnt/efs-access"
    }

    ephemeral_storage {
      size = 512
    }
    depends_on = [
        aws_efs_mount_target.EFSMountTarget,
        aws_efs_mount_target.EFSMountTarget2,
        aws_efs_mount_target.EFSMountTarget3,
        aws_efs_mount_target.EFSMountTarget4,
    ]
    
}

data "aws_caller_identity" "current" {}

resource "aws_lambda_permission" "LambdaPermission" {
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.LambdaFunction.arn}"
    principal = "s3.amazonaws.com"
    source_arn = aws_s3_bucket.S3Bucket.arn
    source_account = data.aws_caller_identity.current.account_id
}


resource "aws_lambda_permission" "LambdaPermission2" {
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.LambdaFunction2.arn}"
    principal = "s3.amazonaws.com"
    source_arn = aws_s3_bucket.S3Bucket.arn
    source_account = data.aws_caller_identity.current.account_id
}
