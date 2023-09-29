variable "cidr_block" { default = "10.0.0.0/16" }

variable "subnet_cidrs" {
  type        = list(string)
  description = "Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "availability_zones" {
  type    = list(any)
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "cluster_name" {}
variable "registry_name" {}

