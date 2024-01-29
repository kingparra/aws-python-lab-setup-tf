resource "tls_private_key" "key_contents" {
  algorithm = "ED25519"
  provisioner "local-exec" {
    # Download private key to ~/.ssh/aws-python-lab.pem
    command = <<-EOF
    set -x
    key_contents='${tls_private_key.key_contents.private_key_openssh}'
    key_file=~/.ssh/aws-python-lab.pem
    echo "$key_contents" > "$key_file"
    chmod 0600 "$key_file"
    EOF
  }
}

resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = tls_private_key.key_contents.public_key_openssh
}
