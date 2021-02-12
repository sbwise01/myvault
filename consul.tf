module "consul_certificate" {
  source            = "git@github.com:FoghornConsulting/m-self-signed-cert?ref=brad.wise/terraform-12-upgrade"
  organization_name = var.certificate_organization_name
  ca_common_name    = var.consul_ca_common_name
  ssc_common_name   = "${var.consul_ssl_host_name}.${var.consul_ca_common_name}"
}

module "consul" {
  #source                  = "git@github.com:FoghornConsulting/m-consul?ref=v0.1.4"
  source                  = "/Users/bwise/src/support-fog-modules/m-consul"
  subnet_ids              = [for subnet in module.aws_vpc.subnets["private"] : subnet.id]
  security_groups         = [module.aws_vpc.default_security_group.id]
  key_name                = aws_key_pair.main.key_name
  enable_encryption       = true
  ca_certificate          = module.consul_certificate.ca_public_key
  certificate             = module.consul_certificate.ssc_public_key
  certificate_private_key = module.consul_certificate.ssc_private_key
  certificate_server_name = "${var.consul_ssl_host_name}.${var.consul_ca_common_name}"

  tags = {
    CostCenter  = var.tag_costcenter
    Name        = var.consul_name
    Environment = var.tag_environment
  }
}

