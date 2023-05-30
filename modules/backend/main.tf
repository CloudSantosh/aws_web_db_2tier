# Creating RDS Instance
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [var.private_subnet_az1_id, var.private_subnet_az2_id]
}

resource "aws_db_instance" "rds_server_backend" {
  allocated_storage = 10
  //db_name                = "awsrestartdb123"
  engine                 = "mysql"
  identifier             = "rds_database"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = "Password"
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [var.private_rds_security_group_id]
  skip_final_snapshot    = true
  //publicly_accessible    = true


}
