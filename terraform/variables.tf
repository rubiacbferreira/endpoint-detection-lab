variable "aws_region" {
  description = "AWS region where the lab will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS CLI profile used for authentication"
  type        = string
  default     = "lab"
}

variable "availability_zone" {
  description = "Availability zone for the lab subnet"
  type        = string
  default     = "us-east-1a"
}

variable "project_name" {
  description = "Project name used for tagging resources"
  type        = string
  default     = "endpoint-detection-lab"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "lab"
}

variable "vpc_cidr" {
  description = "CIDR block for the lab VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.10.1.0/24"
}

variable "admin_ip_cidr" {
  description = "Your public IP in CIDR format (example: 1.2.3.4/32)"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the AWS key pair used to access instances"
  type        = string
}

variable "public_key" {
  description = "Public SSH key content"
  type        = string
  sensitive   = true
}

variable "linux_instance_type" {
  description = "Instance type for the Linux endpoint"
  type        = string
  default     = "t3.small"
}

variable "windows_instance_type" {
  description = "Instance type for the Windows endpoint"
  type        = string
  default     = "t3.medium"
}

variable "linux_root_volume_size" {
  description = "Root volume size for Linux instance"
  type        = number
  default     = 20
}

variable "windows_root_volume_size" {
  description = "Root volume size for Windows instance"
  type        = number
  default     = 50
}