data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = true

  user_data = var.user_data

  tags = merge(
    {
      "Name" = var.name
    },
    var.tags
  )
}
