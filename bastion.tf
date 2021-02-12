resource "aws_iam_policy" "bastion" {
  name_prefix = var.bastion_name
  path        = "/"
  description = "Policy for bastion ${var.bastion_name} ${var.tag_environment}"
  policy      = var.bastion_iam_policy
}

module "bastion" {
  #source = "git@github.com:FoghornConsulting/m-bastion?ref=v0.3.3"
  source = "/Users/bwise/src/support-fog-modules/m-bastion"

  key_name        = aws_key_pair.main.key_name
  security_groups = [module.aws_vpc.default_security_group.id, module.consul.sg_agent.id]
  subnets         = [for subnet in module.aws_vpc.subnets["public"] : subnet.id]

  iam_policies = {
    Bastion = aws_iam_policy.bastion.arn
  }

  tags = {
    CostCenter  = var.tag_costcenter
    Name        = var.bastion_name
    Environment = var.tag_environment
  }

  user_data = <<EOF
module.consul.user_data_dns_centos
module.consul.user_data_ui_linux
module.consul.user_data_checks_system_linux
module.consul.user_data_agent_centos_sysd
EOF

}

