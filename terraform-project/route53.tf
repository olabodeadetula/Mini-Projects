variable "domain_name" {
  default    = "olabodeadetula.me"
  type        = string
  description = "Domain name"
}
# get hosted zone details
resource "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
  tags = {
    Environment = "dev"
  }
}
# create a record set in route 53
# terraform aws route 53 record
resource "aws_route53_record" "site_domain" {
  zone_id = aws_route53_zone.hosted_zone.zone_id
  name    = "terraform-test.${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_lb.terraform-load-balancer.dns_name
    zone_id                = aws_lb.terraform-load-balancer.zone_id
    evaluate_target_health = true
  }
}
