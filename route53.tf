resource "aws_route53_zone" "parent_zone" {
  name              = "aws.bradandmarsha.com"
  delegation_set_id = "N03386422VXZJKGR4YO18"
}

resource "aws_route53_zone" "zone" {
  name              = "${var.tag_name}.aws.bradandmarsha.com"
}

resource "aws_route53_record" "delegation" {
  allow_overwrite = true
  name            = "${var.tag_name}"
  ttl             = 300
  type            = "NS"
  zone_id         = "${aws_route53_zone.parent_zone.id}"
  records         = ["${aws_route53_zone.zone.name_servers}"]
}
