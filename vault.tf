module "vault_certificate" {
  source            = "git@github.com:FoghornConsulting/m-self-signed-cert?ref=brad.wise/terraform-12-upgrade"
  organization_name = var.certificate_organization_name
  ca_common_name    = var.vault_ca_common_name
  ssc_common_name   = "${var.vault_ssl_host_name}.${var.vault_ca_common_name}"
  ca_public_key     = module.consul_certificate.ca_public_key
  ca_private_key    = module.consul_certificate.ca_private_key
}

module "vault" {
  source                   = "git@github.com:FoghornConsulting/m-vault?ref=brad.wise/terraform-12-upgrade"
  instance_subnet_ids      = [for subnet in module.aws_vpc.subnets["private"] : subnet.id]
  instance_security_groups = [module.aws_vpc.default_security_group.id, module.consul.sg_agent.id]
  admin_users              = var.admin_users
  key_name                 = aws_key_pair.main.key_name
  create_lb                = true
  lb_internal              = false
  lb_security_groups       = [module.aws_vpc.default_security_group.id]
  lb_subnet_ids            = [for subnet in module.aws_vpc.subnets["public"] : subnet.id]
  lb_acm_arn               = aws_acm_certificate.cert.arn
  #depends_on               = [module.consul.asg_arn]
  tag_name                = var.tag_name
  tag_costcenter          = var.tag_costcenter
  tag_environment         = var.tag_environment
  tag_application         = var.tag_name
  ca_certificate          = module.vault_certificate.ca_public_key
  certificate             = module.vault_certificate.ssc_public_key
  certificate_private_key = module.vault_certificate.ssc_private_key
  consul_block            = <<EOF
${module.consul.user_data_checks_system_linux}
${module.consul.user_data_agent_centos_sysd}
${module.consul.user_data_dns_centos}
EOF

}

resource "aws_route53_record" "vault" {
  allow_overwrite = true
  name            = ""
  type            = "A"
  zone_id         = aws_route53_zone.zone.id

  alias {
    name                   = module.vault.load_balancer.0.dns_name
    zone_id                = module.vault.load_balancer.0.zone_id
    evaluate_target_health = true
  }
}
