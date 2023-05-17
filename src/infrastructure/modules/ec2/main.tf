resource "aws_key_pair" "wordpress_key_private" {
  key_name   = "wordpress_key"
  public_key = file("~/.ssh/wp_key.pub")
}

resource "aws_instance" "wordpress_node" {
  for_each                    = local.nodes
  instance_type               = "t2.micro"
  ami                         = data.aws_ami.wordpress_ami.id
  key_name                    = aws_key_pair.wordpress_key_private.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = each.value.vpc_security_group_ids
  subnet_id                   = each.value.subnet_id
  tags                        = each.value.tags

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install -y nginx
              sudo service nginx start
              EOF

  root_block_device {
    volume_size = 10
  }
}
