

resource "aws_security_group" "nginx_vm-sg" {
  name        = "nginx_vm-sg"
  description = "nginx_vm-sg"
  vpc_id      = aws_vpc.nginx_vpc.id

  tags = local.common_tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.nginx_vm-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

# port 80 for HTTP
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.nginx_vm-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}




resource "aws_instance" "example" {
  ami                         = "ami-0957c8341302362a3"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.nginx_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.nginx_vm-sg.id]
  associate_public_ip_address = true

  tags = local.common_tags
  
  lifecycle {
    create_before_destroy = true
  }

}