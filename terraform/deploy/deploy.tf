module "eks" {
  source        = "../module/eks"
  registry_name = "simple-time-app"
  cluster_name  = "devops-assessment"
}

