terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "windows" {
  most_recent = true
  owners      = ["801119661308"] # Amazon

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_vpc" "lab_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "lab-vpc"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
    Name        = "public-subnet-a"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "lab_igw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    Name        = "lab-igw"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab_igw.id
  }

  tags = {
    Name        = "public-rt"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "linux_sg" {
  name        = "lab-linux-sg"
  description = "Security group for Linux lab instance"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    description = "SSH from trusted IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "lab-linux-sg"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_security_group" "windows_sg" {
  name        = "lab-windows-sg"
  description = "Security group for Windows lab instance"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    description = "RDP from trusted IP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [var.admin_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "lab-windows-sg"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_key_pair" "lab_key" {
  key_name   = var.key_pair_name
  public_key = var.public_key
}

resource "aws_instance" "linux" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.linux_instance_type
  subnet_id                   = aws_subnet.public_subnet_a.id
  vpc_security_group_ids      = [aws_security_group.linux_sg.id]
  key_name                    = aws_key_pair.lab_key.key_name
  associate_public_ip_address = true
  user_data                   = file("${path.module}/user-data/linux-bootstrap.sh")

  root_block_device {
    volume_size = var.linux_root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name        = "lab-linux-01"
    Project     = var.project_name
    Environment = var.environment
    Role        = "linux-endpoint"
  }
}

resource "aws_instance" "windows" {
  ami                         = data.aws_ami.windows.id
  instance_type               = var.windows_instance_type
  subnet_id                   = aws_subnet.public_subnet_a.id
  vpc_security_group_ids      = [aws_security_group.windows_sg.id]
  key_name                    = aws_key_pair.lab_key.key_name
  associate_public_ip_address = true
  get_password_data           = true
  user_data                   = file("${path.module}/user-data/windows-bootstrap.ps1")

  root_block_device {
    volume_size = var.windows_root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name        = "lab-win-01"
    Project     = var.project_name
    Environment = var.environment
    Role        = "windows-endpoint"
  }
}