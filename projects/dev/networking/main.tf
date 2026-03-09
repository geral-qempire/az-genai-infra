module "networking" {
  source = "../../../stacks/networking"

  service_prefix          = var.service_prefix
  location                = var.location
  vnet_address_space      = var.vnet_address_space
  subnet_address_prefixes = var.subnet_address_prefixes
  tags                    = var.tags
}
