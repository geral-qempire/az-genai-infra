module "private_dns_zones" {
  source = "../../../stacks/private-dns-zones"

  service_prefix = var.service_prefix
  location       = var.location
  tags           = var.tags
}
