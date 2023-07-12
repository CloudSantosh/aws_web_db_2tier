#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#   use data source to get all avalablility zones in region
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
data "aws_availability_zones" "available_zones" {}

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  fetching AMI ID
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
  owners = ["amazon"]
}


#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  creating ec2 instances in public subnet
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "frontend-webserver" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  count         = 1
  key_name      = var.keypair_name
  subnet_id     = var.public_subnet_az1_id
  //associate_public_ip_address = true
  // vpc_id            = var.vpc_id
  security_groups = var.public_ec2_security_group_id
  //security_groups = [var.public_ec2_security_group_id[0]]
  //availability_zone = data.aws_availability_zones.az.names[0]
  user_data = data.template_file.user_data.rendered

  tags = {
    Name = "${var.project_name}-Web-Server"
  }
}
/*
resource "aws_instance" "Jump-server" {
  ami             = data.aws_ami.amazon_linux_2.id
  instance_type   = var.instance_type
  count           = 1
  key_name        = var.keypair_name
  subnet_id       = var.public_subnet_az1_id
  security_groups = [var.public_ec2_security_group_id[1]]

  tags = {
    Name = "${var.project_name}-Jump-Server"
  }
}

resource "aws_instance" "jenkins-server" {
  ami=data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  count = 1
  key_name=var.keypair_name
  subnet_id=var.public_subnet_az1_id
  security_groups = [var.public_ec2_security_group_id[0]] 
  user_data = data.template_file.jenksins_data.rendered 

  tags = {
    Name="${var.project_name}-Jenkins-Server"
  }
}
*/
