resource "aws_sagemaker_notebook_instance" "SageMakerNotebookInstance" {
    name = "daisy-SM-Notebook"
    instance_type = "ml.t2.medium"
    subnet_id = "${aws_subnet.EC2Subnet3.id}"
    security_groups = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    role_arn = "${aws_iam_role.IAMRole2.arn}"
    direct_internet_access = "Enabled"
    volume_size = 50
    root_access = "Enabled"
    platform_identifier = "notebook-al2-v1"
}