module "consul_certificate" {
  source            = "git@github.com:FoghornConsulting/m-self-signed-cert?ref=v0.1.0"
  organization_name = "${var.certificate_organization_name}"
  ca_common_name    = "${var.consul_ca_common_name}"
  ssc_common_name   = "${var.consul_ssl_host_name}.${var.consul_ca_common_name}"
}

module "consul" {
  source                  = "git@github.com:FoghornConsulting/m-consul?ref=v0.1.2"
  subnet_ids              = ["${module.aws_vpc.subnets_private}"]
  security_groups         = ["${module.aws_vpc.sg_allhosts}"]
  key_name                = "${aws_key_pair.main.key_name}"
  tag_name                = "${var.consul_name}"
  tag_costcenter          = "${var.tag_costcenter}"
  enable_encryption       = true
  ca_certificate          = "${module.consul_certificate.ca_public_key}"
  certificate             = "${module.consul_certificate.ssc_public_key}"
  certificate_private_key = "${module.consul_certificate.ssc_private_key}"
  certificate_server_name = "${var.consul_ssl_host_name}.${var.consul_ca_common_name}"
}
