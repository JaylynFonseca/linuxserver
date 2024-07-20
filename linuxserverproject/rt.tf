
# 3) Create Route Table
resource "aws_route_table" "RT_linux" {
  vpc_id = aws_vpc.A.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.GW_linux.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.GW_linux.id
  }

  tags = {
    Name = "RT_linux"
  }
}

# 5) Associate Subnet with Route Table
resource "aws_route_table_association" "RT_to_Subnet" {
  subnet_id      = aws_subnet.Subnet_linux.id
  route_table_id = aws_route_table.RT_linux.id
}