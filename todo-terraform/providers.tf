terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.13.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }


  backend "s3" {
    bucket = "yuval-s3-state"
    key    = "portfo/terraform.state"
    region = "ap-south-1"
    dynamodb_table = "yuval-terraform-locks"
  }
}



provider "aws" {
  region = "ap-south-1"
  default_tags {
    tags = var.tags
  }
}


provider "kubernetes" {
  host                   = module.cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
  # token = data.aws_eks_cluster_auth.cluster_auth.token
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.cluster.cluster_name]
    command     = "aws"
  }
}


provider "helm" {
  kubernetes {
    host                   = module.cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(module.cluster.cluster_ca_certificate)
    # token = data.aws_eks_cluster_auth.cluster_auth.token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.cluster.cluster_name]
      command     = "aws"
    }
  }
}
