data "aws_caller_identity" "current" {
}

data "external" "local" {
  program = ["bash", "./getip.sh"]
}
