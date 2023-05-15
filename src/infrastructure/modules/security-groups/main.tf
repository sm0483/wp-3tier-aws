resource "aws_security_group" "load_balancer_sg" {
  name        = "lb_sg"
  description = "public facing load balancer security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_security_group" "web_server_sg" {
  name        = "web_sg"
  description = "web server security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [aws_security_group.load_balancer_sg.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]

  }
}


resource "aws_security_group" "database_sg" {
  name        = "db_sg"
  description = "database security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_server_sg.id]
  }
}


resource "aws_security_group" "efs_sg" {
  name        = "ef_sg"
  description = "elastic file system security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.web_server_sg.id]
    self            = true
  }
}
