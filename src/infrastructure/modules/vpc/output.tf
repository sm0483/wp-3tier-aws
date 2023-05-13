output "vpc_id" {
  value = aws_vpc.this["wordpress_vpc"].id
}
