resource "aws_route53_record" "alias" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = var.record_name
  type    = "A"
  alias {
    name                   = var.alias_target
    zone_id                = data.aws_route53_zone.selected.zone_id
    evaluate_target_health = true
  }
}

data "aws_route53_zone" "selected" {
  name         = var.domain_name
  private_zone = false
}
