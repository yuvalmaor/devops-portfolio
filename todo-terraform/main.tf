
module "network" {
  source             = "./modules/network"
  availability_zones = var.availability_zones
  env                = var.env
  cidr_blocks        = var.cidr_blocks
  private_cidr_blocks       = var.private_cidr_blocks
  num_of_subnets = var.num_of_subnets
  num_route_table = var.num_route_table

}

module "cluster" {
  source             = "./modules/cluster"
  depends_on         = [module.network]
  instance_type      = var.instance_type
  env                = var.env
  vpc_id             = module.network.vpc_id
  instance_sg        = module.network.instance_sg
  availability_zones = var.availability_zones
  subnets_id         = module.network.subnets_id
  private_subnets_id = module.network.private_subnets_id
  min_size           = var.min_size
  max_size           = var.max_size
  desired_size       = var.desired_size
}

module "argocd" {
  source          = "./modules/argocd"
  env             = var.env
  argo_cd_version = var.argo_cd_version
  argo_namespace  = var.argo_namespace
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
}

