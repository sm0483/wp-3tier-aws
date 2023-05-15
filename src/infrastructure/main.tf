module "vpc_module" {
  source = "./modules/vpc"
}

module "subnet_module" {
  source = "./modules/subnets"
  vpc_id = module.vpc_module.vpc_id
}

module "internet_gateway_module" {
  source = "./modules/internet-gateway"
  vpc_id = module.vpc_module.vpc_id
}


module "nat_gateway_module" {
  source     = "./modules/nat-gateway"
  subnet_ids = module.subnet_module.subnet_ids
}

module "route_module" {
  source              = "./modules/route-table"
  subnet_ids          = module.subnet_module.subnet_ids
  nat_ids             = module.nat_gateway_module.nat_ids
  vpc_id              = module.vpc_module.vpc_id
  internet_gateway_id = module.internet_gateway_module.igw_id

}


module "security_group_module" {
  source = "./modules/security-groups"
  vpc_id = module.vpc_module.vpc_id
}

module "database_module" {
  source     = "./modules/database"
  subnet_ids = module.subnet_module.subnet_ids
  db_sg_id   = module.security_group_module.db_sg_id
}
