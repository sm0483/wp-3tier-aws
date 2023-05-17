locals {
  nodes = {
    node_1_public = {
      vpc_security_group_ids = [var.ssh_sg_id]
      subnet_id              = var.subnet_ids.public_1
      tags = {
        "Name" = "wordpress-bastion"
      }
    },

    node_1_private = {
      vpc_security_group_ids = [var.wb_sg_id]
      subnet_id              = var.subnet_ids.private_1
      tags = {
        "Name" = "wordpress-private-wb-1"
      }
    },

    node_2_private = {
      vpc_security_group_ids = [var.wb_sg_id]
      subnet_id              = var.subnet_ids.private_2
      tags = {
        "Name" = "wordpress-private-wb-2"
      }
    },
  }
}


locals {
  ec2_ids = {
    node_1_public  = aws_instance.wordpress_node["node_1_public"].id
    node_1_private = aws_instance.wordpress_node["node_1_private"].id
    node_2_private = aws_instance.wordpress_node["node_2_private"].id
  }
}
