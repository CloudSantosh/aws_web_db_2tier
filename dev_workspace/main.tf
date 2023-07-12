#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# create VPC
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

module "vpc" {
  source                  = "../modules/vpc"
  region                  = var.region
  project_name            = var.project_name
  vpc_cidr                = var.vpc_cidr
  private_subnet_az1_cidr = var.private_subnet_az1_cidr
  private_subnet_az2_cidr = var.private_subnet_az2_cidr
  public_subnet_az1_cidr  = var.public_subnet_az1_cidr
}

module "security" {
  source       = "../modules/security"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id

}

module "keypair" {
  source            = "../modules/keypair"
  keypair_algorithm = var.keypair_algorithm
  rsa_bit           = var.rsa_bit
  keypair_name      = var.keypair_name
}

module "Frontend" {
  source        = "../modules/frontend"
  instance_type = var.instance_type
  keypair_name  = var.keypair_name
  //vpc_id        = module.vpc.vpc_id
  public_subnet_az1_id         = module.vpc.public_subnet_az1_id
  project_name                 = var.project_name
  public_ec2_security_group_id = [module.security.public_ec2_security_group_id]
 # public_ec2_security_group_id = [module.security.public_ec2_security_group_id, module.security.jump_server_security_group_id]

}

module "backend" {
  source                        = "../modules/backend"
  private_subnet_az1_id         = module.vpc.private_subnet_az1_id
  private_subnet_az2_id         = module.vpc.private_subnet_az2_id
  private_rds_security_group_id = module.security.private_rds_security_group_id
}
