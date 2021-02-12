data "aws_caller_identity" "current" {
}

data "external" "local" {
  program = ["bash", "./getip.sh"]
}

data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS*"]
  }

  owners = ["679593333241"]
}

