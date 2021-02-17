variable "admin_users" {
  type        = list(string)
  description = "Typically the IAM user used to deploy the resources.  Must be an IAM user, can not be an IAM role."
  default     = ["brad"]
}

variable "public_key" {
  description = "Value from a public key file.  Used as SSH key of EC2 instances created by both vault and consul modules."
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvPCdlc3Z3Vh/+YjRxjg6imKLkMAWgI6qsMeSNyDE6P9V1gBoKDLuFL2eM49oV8D6sM3uBaQO9S6Cvzi92eaDc+huL3eA6gaFo6gv+F0Vgftq/JnUNMKwEi2c6J204kmszpHwBRcAojz1XsuDpP77U9alJUm7Dl+SLBLcNMfSER62zUJtDhDYUJDzycGtahLDbxEgViI1qXngzXpzqRPJ5v5/MJKlsIUfhI8RnGNxl0g6K6avwxlsMFtD0QH/67bDap0Q/HI94U0JhPEgjtf/mb9JDI5ksDptWtgfQukj5so8I4wLUV4KZa3ij07Ys4j1m1HQ4oQNDNBY7dRZU7Jxx bwise@Brads-MBP"
}

variable "bastion_name" {
  description = "Used to make bastion instance different name than vault and consul instances"
  default     = "bradvault-bastion"
}

variable "consul_name" {
  description = "Used to make consul instances different name than vault and bastion instances"
  default     = "bradvault-consul"
}

variable "tag_name" {
  description = "Used to name resources created"
  default     = "bradvault"
}

variable "tag_costcenter" {
  description = "Used to tag resources for a unique owner, typically an email address"
  default     = "brad@foghornconsulting.com"
}

variable "region" {
  default     = "us-east-1"
  description = "The region to deploy the resources in"
}

variable "tag_environment" {
  default = "staging"
}

variable "certificate_organization_name" {
  default = "Foghorn Consulting Inc."
}

variable "consul_ca_common_name" {
  default = "dc1.consul"
}

variable "consul_ssl_host_name" {
  default = "server"
}

variable "vault_ca_common_name" {
  default = "dc1.vault"
}

variable "vault_ssl_host_name" {
  default = "server"
}

variable "bastion_iam_policy" {
  default = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeInstances"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}

