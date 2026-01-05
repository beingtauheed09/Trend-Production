provider "aws" {
  region = "us-east-1" 
}

# 1. Create a VPC
resource "aws_vpc" "trend_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "Trend-VPC" }
}

# 2. Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.trend_vpc.id
  tags   = { Name = "Trend-IGW" }
}

# 3. Create a Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.trend_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a" # <--- ADD THIS LINE
  tags                    = { Name = "Trend-Subnet" }
}

# 4. Create Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.trend_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = { Name = "Trend-RouteTable" }
}

# 5. Associate Route Table with Subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}

# 6. Security Group for Jenkins (SSH, 8080, and 80)
resource "aws_security_group" "jenkins_sg" {
  name   = "jenkins_sg"
  vpc_id = aws_vpc.trend_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 7. EC2 Instance for Jenkins
resource "aws_instance" "jenkins_server" {
  ami           = "ami-0c7217cdde317cfec" 
  instance_type = "t3.micro"             # <--- Change t2.micro to t3.micro
  # ... rest of the code stays exactly the same
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name      = "jenkins-key"          # MUST exist in AWS Console

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y openjdk-17-jre
              curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt update -y
              sudo apt install jenkins -y
              sudo systemctl start jenkins
              EOF

  tags = { Name = "Jenkins-Server" }
}

# 8. Output the Jenkins URL
output "jenkins_url" {
  value = "http://${aws_instance.jenkins_server.public_ip}:8080"
}