###########
# checkmk #
###########


module "checkmk_sg" {
  source = "cloudposse/security-group/aws"
  attributes = ["https"]
  allow_all_egress = true
  rule_matrix =[
    {
      source_security_group_ids = [module.windows_sg.id]
      rules = [
        {
          key         = "http"
          type        = "ingress"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          description = "Allow HTTP access from trusted security groups"
        },
        {
          key         = "https"
          type        = "ingress"
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          description = "Allow HTTP access from trusted security groups"
        },
      ]
    }
  ]
  vpc_id  = module.vpc.vpc_id
}

# resource "aws_security_group" "checkmk_sg" {
#   tags        = { "Name" = "checkmk-sg" }
#   name_prefix = "checkmk-sg"
#   vpc_id      = module.vpc.vpc_id
#   description = "Allow access from windows server to HTTP/S, allow access from anywhere to SSH."
# }

# resource "aws_security_group_rule" "checkmk_https" {
#   type                     = "ingress"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "tcp"
#   self                     = null
#   description              = "Allow HTTPS ingress."
#   security_group_id        = aws_security_group.checkmk_sg.id
#   source_security_group_id = module.windows_sg.id
# }

# resource "aws_security_group_rule" "checkmk_http" {
#   type                     = "ingress"
#   from_port                = 443
#   to_port                  = 443
#   protocol                 = "tcp"
#   self                     = null
#   description              = "Allow HTTPS ingress."
#   security_group_id        = aws_security_group.checkmk_sg.id
#   source_security_group_id = module.windows_sg.id
# }

# resource "aws_security_group_rule" "checkmk_ssh" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   self                     = null
#   description              = "Allow SSH ingress from anywhere."
#   cidr_blocks              = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.checkmk_sg.id
# }



##########
# widows #
##########
module "windows_sg" {
  source           = "cloudposse/security-group/aws"
  attributes       = ["primary"]
  allow_all_egress = true
  rules = [
    {
      key         = "rdp"
      type        = "ingress"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      self        = null # preferable to self = false
      description = "Allow RDP from anywhere"
    },
  ]
  vpc_id = module.vpc.vpc_id
}
