# 6) Create Security Group to allow ports: 22, 80, 443
resource "aws_security_group" "SG_linux" {
  name        = "SG_linux"
  description = "Allow SSH, HTTP, HTTPS inbound traffic"
  vpc_id      = aws_vpc.A.id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG_linux"
  }
}

# 7) Assign ENI with IP
resource "aws_network_interface" "ENI_A" {
subnet_id = aws_subnet.Subnet_linux.id
private_ips = ["10.0.0.10"]
security_groups = [aws_security_group.SG_linux.id]
}

# 8) Assign Elastic IP to ENI
resource "aws_eip" "EIP_A" {
  domain                       = "vpc"
  network_interface         = aws_network_interface.ENI_A.id
  associate_with_private_ip = "10.0.0.10"
  depends_on                = [aws_internet_gateway.GW_linux, aws_instance.Instance_A]
  
  tags = {
    Name = "EIP_A"
  }
}