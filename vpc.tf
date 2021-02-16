module "aws_vpc" {
  source = "git@github.com:FoghornConsulting/m-vpc?ref=v1.2.0"

  tag_map = {
    CostCenter  = var.tag_costcenter
    Name        = var.tag_name
    Environment = var.tag_environment
  }

  subnet_map = {
    public   = 3
    private  = 3
    isolated = 3
  }
}
