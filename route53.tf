data "aws_route53_zone" "parent_zone" {
  name         = "superscalability.com."
}

resource "aws_route53_zone" "zone" {
  name = "${var.tag_name}.superscalability.com"
}

resource "aws_route53_record" "delegation" {
  allow_overwrite = true
  name            = var.tag_name
  ttl             = 300
  type            = "NS"
  zone_id         = data.aws_route53_zone.parent_zone.id
  records         = aws_route53_zone.zone.name_servers
}

