variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type    = string
  default = "vpc-067219fd83ef796db"
}

variable "subnet_id" {
  type    = string
  default = "subnet-0e1d521cc75143cbb"
}

variable "security_group_id" {
  type    = string
  default = "sg-057073c08616952bd"
}

variable "ami_id" {
  type    = string
  default = "ami-09c813fb71547fc4f"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "name_prefix" {
  type    = string
  default = "RHEL-9-DevOps-Practice"
}

variable "enable_security_hub" {
  type    = bool
  default = false
}
