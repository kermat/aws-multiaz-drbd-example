variable "keyname"{
  description = "aws keypair to place on instances"
  default     = "aws-keypair"
}

variable "region" {
  description = "default region"
  type        = string
  default     = "us-west-2"
}

variable "ami" {
  description = "LINBIT Ubuntu AMI specific to your region"
  type        = string
  default     = "ami-0eb6700a9a657a42f"
}

variable "ec2_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.small"
}

variable "ebs_type" {
  description = "ebs volume type"
  type        = string
  default     = "gp3"
}

variable "ebs_size" {
  description = "ebs size for DRBD volume in GiB"
  type        = string
  default     = 100
}

# ubuntu 22.04 LTS 64-bit (x86) in us-west-2
variable "bastion_ami" {
  description = "ami for the bastion host's image specific to region"
  type        = string
  default     = "ami-0d70546e43a941d70"
}

variable "bastion_ec2_type" {
  description = "bastion host's ec2 instance type"
  type        = string
  default     = "t2.micro"
}

# WARNING: Changing the subnets below will require updates to the
# DRBD replication network variable in Ansible hosts.tpl.
variable "vpc_cidr" {
  description = "default vpc_cidr_block"
  type        = string
  default     = "172.17.0.0/16"
}

variable "pub_sub1_cidr_block" {
  description = "regions first AZ subnet eg. us-west-2a"
  type        = string
  default     = "172.17.1.0/24"
}

variable "pub_sub2_cidr_block" {
  description = "regions second AZ subnet eg. us-west-2b"
  type        = string
  default     = "172.17.2.0/24"
}

variable "pub_sub3_cidr_block" {
  description = "regions third AZ subnet eg. us-west-2c"
  type        = string
  default     = "172.17.3.0/24"
}

variable "pri_sub1_cidr_block" {
  description = "regions first AZ subnet eg. us-west-2a"
  type        = string
  default     = "172.17.101.0/24"
}

variable "pri_sub2_cidr_block" {
  description = "regions first AZ subnet eg. us-west-2b"
  type        = string
  default     = "172.17.102.0/24"
}

variable "pri_sub3_cidr_block" {
  description = "regions first AZ subnet eg. us-west-2c"
  type        = string
  default     = "172.17.103.0/24"
}
