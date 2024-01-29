data "aws_ami" "ubuntu" {
  # filters based on ami-0c7217cdde317cfec
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on *"]
  }
}

data "aws_ami" "windows_server_2022" {
  # filters based on ami-00d990e7e5ece7974
  most_recent = true
  owners      = ["801119661308"] # MicroSoft
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}
