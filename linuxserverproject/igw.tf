# 2) Create Internet Gateway
resource "aws_internet_gateway" "GW_linux" {
  vpc_id = aws_vpc.A.id

  tags = {
    Name = "IG_linux"
  }
}