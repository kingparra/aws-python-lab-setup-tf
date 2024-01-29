module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = var.vpc_name_prefix
  cidr   = var.vpc_cidr

  # AZs are mapped to in order to the lists of subnets.
  # Like zip(azs, private_subnets); zip(azs, public_subnets) in python.
  azs             = var.azs
  private_subnets = var.private_subnets_cidrs
  public_subnets  = var.public_subnets_cidrs

  # Set assign_public_ip_address = true for instances on the public subnets
  map_public_ip_on_launch = true

  # Default behaviour is one nat gateway per subnet.
  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  # Control the default NACL associated with every subnet
  manage_default_network_acl = true
  # Use seperate NACLs for the public subnets
  public_dedicated_network_acl = true
  # Use seperate NACLs for the private subnets
  private_dedicated_network_acl = true

  # Names for route tables
  default_route_table_name = "${var.vpc_name_prefix}-default-table"
  private_route_table_tags = { "Name" = "${var.vpc_name_prefix}-private-route-table" }
  public_route_table_tags  = { "Name" = "${var.vpc_name_prefix}-public-route-table" }
  # Names for subnets
  private_subnet_names = ["${var.vpc_name_prefix}-private-subnet-1", "${var.vpc_name_prefix}-private-subnet-2"]
  public_subnet_names  = ["${var.vpc_name_prefix}-public-subnet-1", "${var.vpc_name_prefix}-public-subnet-2"]

  # Name for the NGW
  nat_gateway_tags = { "Name" = "${var.vpc_name_prefix}-nat-gateway" }
}
