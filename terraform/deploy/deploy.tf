module "eks" {
  source        = "../module/eks"
  registry_name = "devops-assessment"
  cluster_name  = "devops-assessment"
}

