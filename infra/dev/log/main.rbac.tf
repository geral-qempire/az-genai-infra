module "rbac_map" {
  source = "../../../modules/rbac-map/resource"

  rbac = {
    genai-engineer-reader = {
      principal_id         = var.aad_group_genai_engineer_object_id
      principal_type       = "Group"
      role_definition_name = "Reader"
      scope_id             = module.log_template.resource_group_id
    }
    genai-techlead-reader = {
      principal_id         = var.aad_group_genai_techlead_object_id
      principal_type       = "Group"
      role_definition_name = "Reader"
      scope_id             = module.log_template.resource_group_id
    }
  }
}


