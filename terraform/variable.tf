variable "github_repo_url" {
  description = "URL to your GitHub repository"
  default     = "https://github.com/kingparra/aws-python"
}

variable "key_name" {
  description = "Name of the key_pair and private key to create."
  default     = "python-class-kp"
}

variable "class_name" {
  default = "python-class"
}

variable "vpc_name_prefix" {
  type        = string
  default     = "PYTHON-VPC"
  description = "All resources created by this module will be be prepended with prefix, in this form: {prefix}-{resource_name}."
}

variable "vpc_cidr" {
  type    = string
  default = "10.2.0.0/16"
}

variable "azs" {
  type        = list(string)
  description = "The list of AZs that each subnet will reside in."
  default = [
    "us-east-1a",
    "us-east-1b",
    # "us-east-1c",
    # "us-east-1d",
    # "us-east-1e",
    # "us-east-1f"
  ]
}

# https://www.davidc.net/sites/default/subnets/subnets.html?network=10.2.0.0&mask=16&division=39.f46455d231
variable "public_subnets_cidrs" {
  type        = list(string)
  description = "CIDRs for each public subnet."
  # at least 200 hosts per subnet
  default = [
    "10.2.0.0/20",
    "10.2.16.0/20",
    # "10.2.32.0/20",
    # "10.2.48.0/20",
    # "10.2.64.0/20",
    # "10.2.80.0/20",
  ]
}

variable "private_subnets_cidrs" {
  type        = list(string)
  description = "CIDRs for each private subnet."
  # no more than 62 hosts per subnet
  default = [
    "10.2.254.128/26",
    "10.2.254.192/26",
    # "10.2.255.0/26",
    # "10.2.255.64/26",
    # "10.2.255.128/26",
    # "10.2.255.192/26",
  ]
}
