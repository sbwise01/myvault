module "aws_vpc" {
  source          = "git@github.com:FoghornConsulting/m-vpc?ref=v0.2.8"
  adminip         = "${data.external.local.result.adminip}"
  owner           = "${var.tag_costcenter}"
  tag_name        = "${var.tag_name}"
  tag_costcenter  = "${var.tag_costcenter}"
  tag_environment = "${var.tag_environment}"

  subnet_map = {
    public   = 3
    private  = 3
    isolated = 3
  }
}
