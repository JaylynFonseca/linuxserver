# 10) Create Linux Server and Install/Enable Apache2
resource "aws_instance" "Instance_A" {
  ami                  = "ami-0947d2ba12ee1ff75" 
  instance_type        = "t2.micro"
  availability_zone    = "us-east-1a"
  key_name             = "linuxuser"
  iam_instance_profile = "${aws_iam_instance_profile.linuxuser_Profile.name}"
  
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.ENI_A.id
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y httpd.x86_64
    sudo systemctl start httpd.service
    sudo systemctl enable httpd.service
    sudo aws s3 sync s3://awsbucketbeta00/website /var/www/html 
  EOF

  tags = {
    Name = "linuxserver_1.0"
  }
}