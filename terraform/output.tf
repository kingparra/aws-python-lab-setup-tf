output "private_key" {
  value     = tls_private_key.key_contents.private_key_openssh
  sensitive = true
}

output "cloud9_url" {
  value = "https://us-east-1.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.env.id}"
}

output "checkmk_ssh_cmd" {
  value = "ssh ubuntu@${aws_instance.checkmk.public_ip}"
}

output "windows_ip" {
  value = "${aws_instance.windows.public_ip}:3389"
}