# Route 53 Hosted Zone setup
resource "aws_route53_zone" "my_zone" {
  name = var.route53_zone_name
  tags = {
    Name = var.route53_zone_name
  }
}

# Route 53 Record Set for the ALB
resource "aws_route53_record" "alb_record" {
  zone_id = aws_route53_zone.my_zone.zone_id
  name    = var.route53_record_name
  type    = "A"
  alias {
    name                   = aws_lb.my_alb.dns_name
    zone_id                = aws_lb.my_alb.zone_id
    evaluate_target_health = true
  }
}
