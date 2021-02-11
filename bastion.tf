module "bastion" {
  source = "git@github.com:FoghornConsulting/m-bastion?ref=v0.3.2"

  key_name        = "${aws_key_pair.main.key_name}"
  security_groups = ["${module.aws_vpc.sg_allhosts}", "${module.consul.sg_agent}"]
  subnets         = ["${module.aws_vpc.subnets_public}"]
  iam_policy      = "${var.bastion_iam_policy}"
  tag_name        = "${var.bastion_name}"
  tag_costcenter  = "${var.tag_costcenter}"

  user_data_append = <<EOF
${module.consul.user_data_dns_centos}
${module.consul.user_data_ui_linux}
${module.consul.user_data_checks_system_linux}
${module.consul.user_data_agent_centos_sysd}
EOF
}
