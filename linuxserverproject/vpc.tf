# 1) Create VPC
resource "aws_vpc" "A" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    name = "linuxvpc"
  }
}

# 4) Create Subnet
resource "aws_subnet" "Subnet_linux" {
  vpc_id     = aws_vpc.A.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  depends_on = [aws_internet_gateway.GW_linux
]

  tags = {
    Name = "Subnet_Codewithmuh"
  }
}

# 11) Enable VCP Endpoint
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.A.id
  service_name = "com.amazonaws.us-east-1.s3"

  tags = {
    Environment = "test"
  }
}

