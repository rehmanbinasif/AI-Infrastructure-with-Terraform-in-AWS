resource "aws_efs_file_system" "EFSFileSystem" {
    performance_mode = "generalPurpose"
    encrypted = true
    throughput_mode = "bursting"
    tags = {
        Name = "deepspine-EFS"
        default-backup = "enabled"
    }
}

resource "aws_efs_mount_target" "EFSMountTarget" {
    file_system_id = "${aws_efs_file_system.EFSFileSystem.id}"
    ip_address = "172.31.16.101"
    security_groups = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    subnet_id = "${aws_subnet.EC2Subnet.id}"
}

resource "aws_efs_mount_target" "EFSMountTarget2" {
    file_system_id = "${aws_efs_file_system.EFSFileSystem.id}"
    ip_address = "172.31.48.144"
    security_groups = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    subnet_id = "${aws_subnet.EC2Subnet2.id}"
}

resource "aws_efs_mount_target" "EFSMountTarget3" {
    file_system_id = "${aws_efs_file_system.EFSFileSystem.id}"
    ip_address = "172.31.32.249"
    security_groups = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    subnet_id = "${aws_subnet.EC2Subnet3.id}"
}

resource "aws_efs_mount_target" "EFSMountTarget4" {
    file_system_id = "${aws_efs_file_system.EFSFileSystem.id}"
    ip_address = "172.31.0.246"
    security_groups = [
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    subnet_id = "${aws_subnet.EC2Subnet4.id}"
}
resource "aws_efs_access_point" "efs_access_point" {
  file_system_id = aws_efs_file_system.EFSFileSystem.id

  tags = {
    "Name" = "deepspine-EFS-AP"
  }

  root_directory {
    path = "/"
  }
}
