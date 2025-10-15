resource "aws_vpc" "nginx_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "nginx"
  }
}

resource "aws_subnet" "nginx_public_subnet" {
  vpc_id     = aws_vpc.nginx_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "nginx"
  }
}

resource "aws_internet_gateway" "nginx_vpc_gw" {
  vpc_id = aws_vpc.nginx_vpc.id

  tags = {
    Name = "nginx"
  }
}

resource "aws_route_table" "nginx_public_subnet_rt" {
  vpc_id = aws_vpc.nginx_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nginx_vpc_gw.id
  }

  tags = {
    Name = "nginx"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.nginx_public_subnet.id
  route_table_id = aws_route_table.nginx_public_subnet_rt.id
}


resource "aws_security_group" "nginx_vm-sg" {
  name        = "nginx_vm-sg"
  description = "nginx_vm-sg"
  vpc_id      = aws_vpc.nginx_vpc.id

  tags = {
    Name = "nginx"
  }
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
  ami =  "ami-0957c8341302362a3"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.nginx_public_subnet.id
  vpc_security_group_ids      = [aws_security_group.nginx_vm-sg.id]
  associate_public_ip_address = true

  tags = {
    Name = "nginx"
  }
}