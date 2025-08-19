module "hub_outbound_rules" {
  source = "../modules/hub-outbound-rules/resource"

  workspace_id = module.base_resources.ai_hub_id

  outbound_rules = {
    rule0001 = {
      type        = "FQDN"
      destination = "tpypi.org"
    }

    rule0002 = {
      type                = "private-endpoint"
      service_resource_id = module.base_resources.ai_search_id
      sub_resource_target = "searchService"
    }
  }
}


