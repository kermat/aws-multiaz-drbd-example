terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = var.region
}

# VPC and Networking
resource "aws_vpc" "drbd-cluster" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_subnet" "pub_sub1" {
  vpc_id                  = aws_vpc.drbd-cluster.id
  cidr_block              = var.pub_sub1_cidr_block
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_subnet" "pub_sub2" {
  vpc_id                  = aws_vpc.drbd-cluster.id
  cidr_block              = var.pub_sub2_cidr_block
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_subnet" "pub_sub3" {
  vpc_id                  = aws_vpc.drbd-cluster.id
  cidr_block              = var.pub_sub3_cidr_block
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_subnet" "pri_sub1" {
  vpc_id                  = aws_vpc.drbd-cluster.id
  cidr_block              = var.pri_sub1_cidr_block
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_subnet" "pri_sub2" {
  vpc_id                  = aws_vpc.drbd-cluster.id
  cidr_block              = var.pri_sub2_cidr_block
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_subnet" "pri_sub3" {
  vpc_id                  = aws_vpc.drbd-cluster.id
  cidr_block              = var.pri_sub3_cidr_block
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = false
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_route_table" "pub_sub1_rt" {
  vpc_id = aws_vpc.drbd-cluster.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_route_table" "pub_sub2_rt" {
  vpc_id = aws_vpc.drbd-cluster.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_route_table" "pub_sub3_rt" {
  vpc_id = aws_vpc.drbd-cluster.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_route_table_association" "internet_for_pub_sub1" {
  route_table_id = aws_route_table.pub_sub1_rt.id
  subnet_id      = aws_subnet.pub_sub1.id
}

resource "aws_route_table_association" "internet_for_pub_sub2" {
  route_table_id = aws_route_table.pub_sub2_rt.id
  subnet_id      = aws_subnet.pub_sub2.id
}

resource "aws_route_table_association" "internet_for_pub_sub3" {
  route_table_id = aws_route_table.pub_sub3_rt.id
  subnet_id      = aws_subnet.pub_sub3.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.drbd-cluster.id
  tags   = {
    Name = "drbd-cluster"
  }
}

resource "aws_eip" "eip_natgw1" {
  count = "1"
}

resource "aws_nat_gateway" "natgw1" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw1[count.index].id
  subnet_id     = aws_subnet.pub_sub1.id
}

resource "aws_eip" "eip_natgw2" {
  count = "1"
}

resource "aws_nat_gateway" "natgw2" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw2[count.index].id
  subnet_id     = aws_subnet.pub_sub2.id
}

resource "aws_eip" "eip_natgw3" {
  count = "1"
}

resource "aws_nat_gateway" "natgw3" {
  count         = "1"
  allocation_id = aws_eip.eip_natgw3[count.index].id
  subnet_id     = aws_subnet.pub_sub3.id
}

resource "aws_route_table" "pri_sub1_rt" {
  count  = "1"
  vpc_id = aws_vpc.drbd-cluster.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw1[count.index].id
  }
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_route_table_association" "pri_sub1_to_natgw1" {
  count          = "1"
  route_table_id = aws_route_table.pri_sub1_rt[count.index].id
  subnet_id      = aws_subnet.pri_sub1.id
}

resource "aws_route_table" "pri_sub2_rt" {
  count  = "1"
  vpc_id = aws_vpc.drbd-cluster.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw2[count.index].id
  }
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_route_table_association" "pri_sub2_to_natgw2" {
  count          = "1"
  route_table_id = aws_route_table.pri_sub2_rt[count.index].id
  subnet_id      = aws_subnet.pri_sub2.id
}

resource "aws_route_table" "pri_sub3_rt" {
  count  = "1"
  vpc_id = aws_vpc.drbd-cluster.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw3[count.index].id
  }
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_route_table_association" "pri_sub3_to_natgw3" {
  count          = "1"
  route_table_id = aws_route_table.pri_sub3_rt[count.index].id
  subnet_id      = aws_subnet.pri_sub3.id
}

# DRBD Instances
resource "aws_launch_configuration" "drbd-cluster" {
  image_id        = var.ami
  instance_type   = var.ec2_type
  key_name        = var.keyname
  security_groups = [aws_security_group.drbd-instance.id]
  user_data       = "${file("init.sh")}"
  root_block_device {
    volume_type = "gp2"
    volume_size = 20
    encrypted   = true
  }
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp3"
    volume_size = 100
    encrypted   = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "drbd-cluster" {
  launch_configuration = aws_launch_configuration.drbd-cluster.name
  vpc_zone_identifier  = ["${aws_subnet.pri_sub1.id}","${aws_subnet.pri_sub2.id}","${aws_subnet.pri_sub3.id}"]
  health_check_type    = "EC2"
  suspended_processes  = [
    "Launch",
    "Terminate",
    "AZRebalance",
    "HealthCheck",
    "ReplaceUnhealthy",
    "AddToLoadBalancer",
    "AlarmNotification",
    "InstanceRefresh",
    "ScheduledActions",
    "RemoveFromLoadBalancerLowPriority"
  ]
  min_size = 3
  max_size = 3
  tag {
    key                 = "Name"
    value               = "drbd-cluster-asg"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "drbd-instance" {
  name   = "drbd-cluster-node-sg"
  vpc_id = aws_vpc.drbd-cluster.id
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
  ingress {
    from_port = 7000
    to_port   = 7000
    protocol  = "tcp"
    self      = true
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "drbd-cluster"
  }
}

# Bastion Host
resource "aws_security_group" "bastion" {
  name   = "drbd-cluster-bastion-sg"
  vpc_id = aws_vpc.drbd-cluster.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "drbd-cluster"
  }
}

resource "aws_instance" "bastion" {
  ami           = var.bastion_ami
  instance_type = var.bastion_ec2_type
  key_name      = var.keyname
  subnet_id     = aws_subnet.pub_sub3.id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  tags = {
    Name = "bastion"
  }
}

# Data sources for outputs and local ansible inventory file
data "aws_instances" "nodes" {
  depends_on    = [aws_autoscaling_group.drbd-cluster]
  instance_tags = {
    Name = "drbd-cluster-asg"
  }
}

# local ansible inventory file
resource "local_file" "host-ini" {
  content = templatefile("hosts.tpl",
    {
      nodes   = data.aws_instances.nodes.private_ips
      bastion = aws_instance.bastion.public_ip
    }
  )
  filename = "hosts.ini"
}
