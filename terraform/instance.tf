resource "aws_instance" "checkmk" {
  tags                   = { Name = "checkmk" }
  subnet_id              = module.vpc.public_subnets[0]
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.checkmk_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
  key_name = aws_key_pair.key.key_name
  user_data              = <<-EOF
  wget https://download.checkmk.com/checkmk/2.1.0p18/check-mk-raw-2.1.0p18_0.focal_amd64.deb
  apt install check-mk-raw-2.1.0p18_0.focal_amd64.deb
  omd create ytmonitoring
  omd start ytmonitoring
  EOF
}

resource "aws_instance" "windows" {
  tags = { Name = "windows" }
  ami                    = data.aws_ami.windows_server_2022.id
  instance_type          = "t2.micro"
  key_name = aws_key_pair.key.key_name
  vpc_security_group_ids = [module.windows_sg.id]
  subnet_id = module.vpc.public_subnets[0]
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name
}
