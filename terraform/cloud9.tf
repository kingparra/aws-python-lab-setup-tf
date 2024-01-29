resource "aws_cloud9_environment_ec2" "env" {
  instance_type = "t2.micro"
  name          = "python-automation"
  image_id      = "amazonlinux-2-x86_64"
  subnet_id     = module.vpc.public_subnets[0]
}

data "aws_instance" "cloud9_instance" {
  filter {
    name = "tag:aws:cloud9:environment"
    values = [
      aws_cloud9_environment_ec2.env.id
    ]
  }
}
