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
  description = "ami for the Ubuntu image specific to region (Ubuntu 18.04+)"
  type        = string
  default     = "ami-0a11efe61747c2317"
}

variable "ec2_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "bastion_ami" {
  description = "ami for the bastion host's image specific to region"
  type        = string
  default     = "ami-0a11efe61747c2317"
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
  default     = "172.16.0.0/16"
}

variable "pub_sub1_cidr_block" {
  description = "regions first AZ subnet eg. us-west-2a"
  type        = string
  default     = "172.16.1.0/24"
}

variable "pub_sub2_cidr_block" {
  description = "regions second AZ subnet eg. us-west-2b"
  type        = string
  default     = "172.16.2.0/24"
}

variable "pub_sub3_cidr_block" {
  description = "regions third AZ subnet eg. us-west-2c"
  type        = string
  default     = "172.16.3.0/24"
}

variable "pri_sub1_cidr_block" {
  description = "regions first AZ subnet eg. us-west-2a"
  type        = string
  default     = "172.16.101.0/24"
}

variable "pri_sub2_cidr_block" {
  description = "regions first AZ subnet eg. us-west-2b"
  type        = string
  default     = "172.16.102.0/24"
}

variable "pri_sub3_cidr_block" {
  description = "regions first AZ subnet eg. us-west-2c"
  type        = string
  default     = "172.16.103.0/24"
}
