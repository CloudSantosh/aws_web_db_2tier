
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  create security group for the FrontEnd
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "public_ec2_security_group" {
  name        = "public ec2 instance security group"
  description = "enable http/https access on port 80/443 via ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.alb_security_group.id]
  }

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.alb_security_group.id]

  }
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "outbound access"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-public-ec2-security-group"
  }
}

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  create Jump Server security
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
resource "aws_security_group" "jump_server_security_group" {
  name   = "Jump-server security Group"
  vpc_id = var.vpc_id

  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-jump-server-security-group"
  }
}

*/
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  create security group for Backend
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "private_rds_security_group" {
  name   = "RDS security Group"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ec2_security_group.id]
    #security_groups = [aws_security_group.public_ec2_security_group.id, aws_security_group.jump_server_security_group.id]

  }
  egress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ec2_security_group.id]
  }
  /*
  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.public_ec2_security_group.id]
    #security_groups = [aws_security_group.public_ec2_security_group.id, aws_security_group.jump_server_security_group.id]
  }

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.public_ec2_security_group.id]
    #security_groups = [aws_security_group.public_ec2_security_group.id, aws_security_group.jump_server_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
*/
  tags = {
    Name = "${var.project_name}-private-rds-security-group"
  }
}
