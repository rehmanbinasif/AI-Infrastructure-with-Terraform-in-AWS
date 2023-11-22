resource "aws_vpc" "EC2VPC" {
    cidr_block = "172.31.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "carlsmed-vnv"
    }
}

resource "aws_vpc_endpoint" "EC2VPCEndpoint" {
    vpc_endpoint_type = "Interface"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    service_name = "com.amazonaws.${var.region}.sqs"
    policy = <<EOF
{
  "Statement": [
    {
      "Action": "*", 
      "Effect": "Allow", 
      "Principal": "*", 
      "Resource": "*"
    }
  ]
}
EOF
    subnet_ids = [
        "${aws_subnet.EC2Subnet.id}",
        "${aws_subnet.EC2Subnet2.id}",
        "${aws_subnet.EC2Subnet3.id}",
        "${aws_subnet.EC2Subnet4.id}"
    ]
    private_dns_enabled = true
    security_group_ids = [
        "${aws_security_group.EC2SecurityGroup2.id}",
        "${aws_security_group.EC2SecurityGroup4.id}",
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    tags = {
        Name = "deepspine-endpoint-sqs"
    }
}

resource "aws_vpc_endpoint" "EC2VPCEndpoint3" {
    vpc_endpoint_type = "Interface"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    service_name = "com.amazonaws.${var.region}.sagemaker.runtime"
    policy = <<EOF
{
  "Statement": [
    {
      "Action": "*", 
      "Effect": "Allow", 
      "Principal": "*", 
      "Resource": "*"
    }
  ]
}
EOF
    subnet_ids = [
        "${aws_subnet.EC2Subnet.id}",
        "${aws_subnet.EC2Subnet2.id}",
        "${aws_subnet.EC2Subnet3.id}",
        "${aws_subnet.EC2Subnet4.id}"
    ]
    private_dns_enabled = true
    security_group_ids = [
        "${aws_security_group.EC2SecurityGroup2.id}",
        "${aws_security_group.EC2SecurityGroup4.id}",
        "${aws_security_group.EC2SecurityGroup.id}"
    ]
    tags = {
        Name = "deepspine-endpoint-sagemaker"
    }
}

resource "aws_vpc_endpoint" "EC2VPCEndpoint2" {
    vpc_endpoint_type = "Gateway"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    service_name = "com.amazonaws.${var.region}.s3"
    policy = "{\"Version\":\"2008-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"*\",\"Resource\":\"*\"}]}"
    route_table_ids = [
        "${aws_route_table.EC2RouteTable.id}"
    ]
    private_dns_enabled = false
    tags = {
        Name = "deepspine-endpoint"
    }
}

resource "aws_security_group" "EC2SecurityGroup" {
    description = "deepspine-srv-SG"
    name = "deepspine-srv-SG"
    tags = {}
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }
    ingress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }
    ingress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 8000
        protocol = "tcp"
        to_port = 8000
    }
    ingress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 8000
        protocol = "tcp"
        to_port = 8000
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 443
        protocol = "tcp"
        to_port = 443
    }
    ingress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 443
        protocol = "tcp"
        to_port = 443
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 2049
        protocol = "tcp"
        to_port = 2049
    }
    ingress {
        ipv6_cidr_blocks = [
            "::/0"
        ]
        from_port = 2049
        protocol = "tcp"
        to_port = 2049
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "EC2SecurityGroup2" {
    description = "SG for vnv-f01"
    name = "wf-vnv-f01-ecs-sg"
    tags = {}
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 80
        protocol = "tcp"
        to_port = 80
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 443
        protocol = "tcp"
        to_port = 443
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "EC2SecurityGroup3" {
    description = "xray_images created 2023-10-03T10:04:23.764Z"
    name = "xray_images"
    tags = {}
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 8000
        protocol = "tcp"
        to_port = 8000
    }
    ingress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 22
        protocol = "tcp"
        to_port = 22
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_security_group" "EC2SecurityGroup4" {
    description = "default VPC security group"
    name = "carlsmed-sg"
    tags = {}
    vpc_id = "${aws_vpc.EC2VPC.id}"
    ingress {
        cidr_blocks = [
            "104.59.74.229/32"
        ]
        description = "jeff+work"
        from_port = 5432
        protocol = "tcp"
        to_port = 5432
    }
    ingress {
        cidr_blocks = [
            "99.50.203.178/32"
        ]
        description = "jeff+home"
        from_port = 5432
        protocol = "tcp"
        to_port = 5432
    }
    ingress {
        security_groups = [
            "${aws_security_group.EC2SecurityGroup2.id}"
        ]
        description = "ECS vnv-f01"
        from_port = 5432
        protocol = "tcp"
        to_port = 5432
    }
    egress {
        cidr_blocks = [
            "0.0.0.0/0"
        ]
        from_port = 0
        protocol = "-1"
        to_port = 0
    }
}

resource "aws_subnet" "EC2Subnet" {
    availability_zone = "${var.region}b"
    cidr_block = "172.31.16.0/20"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet2" {
    availability_zone = "${var.region}d"
    cidr_block = "172.31.48.0/20"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet3" {
    availability_zone = "${var.region}a"
    cidr_block = "172.31.32.0/20"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_subnet" "EC2Subnet4" {
    availability_zone = "${var.region}c"
    cidr_block = "172.31.0.0/20"
    vpc_id = "${aws_vpc.EC2VPC.id}"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "EC2InternetGateway" {
    tags = {}
    vpc_id = "${aws_vpc.EC2VPC.id}"
}

resource "aws_route" "EC2Route" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.EC2InternetGateway.id}"
    route_table_id = "${aws_route_table.EC2RouteTable.id}"
}

resource "aws_vpc_dhcp_options" "EC2DHCPOptions" {
    domain_name = "${var.region}.compute.internal"
    tags = {}
}

resource "aws_network_acl" "EC2NetworkAcl" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {}
}

resource "aws_network_acl_rule" "EC2NetworkAclEntry" {
    cidr_block = "0.0.0.0/0"
    egress = true
    network_acl_id = "${aws_network_acl.EC2NetworkAcl.id}"
    protocol = -1
    rule_action = "allow"
    rule_number = 100
}

resource "aws_network_acl_rule" "EC2NetworkAclEntry2" {
    cidr_block = "0.0.0.0/0"
    egress = false
    network_acl_id = "${aws_network_acl.EC2NetworkAcl.id}"
    protocol = -1
    rule_action = "allow"
    rule_number = 100
}

resource "aws_route_table" "EC2RouteTable" {
    vpc_id = "${aws_vpc.EC2VPC.id}"
    tags = {}
}

resource "aws_main_route_table_association" "set_main" {
    vpc_id         = aws_vpc.EC2VPC.id
    route_table_id = aws_route_table.EC2RouteTable.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.EC2Subnet.id
  route_table_id = aws_route_table.EC2RouteTable.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.EC2Subnet2.id
  route_table_id = aws_route_table.EC2RouteTable.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.EC2Subnet3.id
  route_table_id = aws_route_table.EC2RouteTable.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.EC2Subnet4.id
  route_table_id = aws_route_table.EC2RouteTable.id
}