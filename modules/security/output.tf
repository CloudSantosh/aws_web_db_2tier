output "public_ec2_security_group_id" {
  value = aws_security_group.public_ec2_security_group.id
}

output "private_rds_security_group_id" {
  value = aws_security_group.private_rds_security_group.id
}
/*
output "jump_server_security_group_id" {
  value = aws_security_group.jump_server_security_group.id
  
}
*/
