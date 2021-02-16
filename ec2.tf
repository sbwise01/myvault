resource "aws_key_pair" "main" {
  key_name_prefix = var.tag_name
  public_key      = var.public_key
}

