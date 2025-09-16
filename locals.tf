locals {
  common_tags = {
    Project   = "Prowler"
    ManagedBy = "terraform"
    VPC       = var.vpc_id
  }
}
