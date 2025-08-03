output "resource_group_name" {
  description = "Name of the test resource group."
  value       = azurerm_resource_group.test.name
}

output "key_vault_id" {
  description = "Azure resource ID of the Key Vault."
  value       = module.key_vault.id
}

output "key_vault_name" {
  description = "Name of the Key Vault."
  value       = module.key_vault.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault for data plane operations."
  value       = module.key_vault.vault_uri
}

output "key_vault_tenant_id" {
  description = "Tenant ID the Key Vault is associated with."
  value       = module.key_vault.tenant_id
}

output "key_vault_sku" {
  description = "SKU name of the Key Vault."
  value       = module.key_vault.sku_name
}

output "availability_alert_id" {
  description = "Azure resource ID of the availability alert."
  value       = module.key_vault_availability_alert.id
}

output "availability_alert_name" {
  description = "Name of the availability alert."
  value       = module.key_vault_availability_alert.name
}

output "saturation_alert_id" {
  description = "Azure resource ID of the saturation alert."
  value       = module.key_vault_saturation_alert.id
}

output "saturation_alert_name" {
  description = "Name of the saturation alert."
  value       = module.key_vault_saturation_alert.name
}

output "latency_alert_id" {
  description = "Azure resource ID of the latency alert."
  value       = module.key_vault_latency_alert.id
}

output "latency_alert_name" {
  description = "Name of the latency alert."
  value       = module.key_vault_latency_alert.name
}

output "action_group_id" {
  description = "Azure resource ID of the action group."
  value       = azurerm_monitor_action_group.test.id
}

output "action_group_name" {
  description = "Name of the action group."
  value       = azurerm_monitor_action_group.test.name
}

output "test_instructions" {
  description = "Instructions for testing the Key Vault and availability alert."
  value = <<-EOT
    Test your Key Vault deployment:
    
    1. Key Vault Access (requires RBAC permissions):
       az keyvault secret set --vault-name ${module.key_vault.name} --name test-secret --value "Hello Key Vault"
       az keyvault secret show --vault-name ${module.key_vault.name} --name test-secret
    
    2. Test Availability Alert:
       - The alert monitors Key Vault availability
       - Current threshold: ${var.availability_threshold}% (fires when below)
       - Severity: 0 (Critical)
       - Evaluation: Every 1 minute over 5-minute window
       - Notifications will be sent to: ${var.alert_email_address}
    
         3. Test Saturation Alert:
        - The alert monitors Key Vault capacity saturation
        - Current threshold: ${var.saturation_threshold}% (fires when above)
        - Severity: 2 (Warning)
        - Evaluation: Every 1 minute over 5-minute window
        - Notifications will be sent to: ${var.alert_email_address}
     
     4. Test Latency Alert:
        - The alert monitors Key Vault API latency
        - Current threshold: ${var.latency_threshold}ms (fires when above)
        - Severity: 1 (Error)
        - Evaluation: Every 1 minute over 5-minute window
        - Notifications will be sent to: ${var.alert_email_address}
    
              5. View Alert Status:
        # Availability Alert
        az monitor metrics alert show --name ${module.key_vault_availability_alert.name} --resource-group ${azurerm_resource_group.test.name}
        
        # Saturation Alert  
        az monitor metrics alert show --name ${module.key_vault_saturation_alert.name} --resource-group ${azurerm_resource_group.test.name}
        
        # Latency Alert
        az monitor metrics alert show --name ${module.key_vault_latency_alert.name} --resource-group ${azurerm_resource_group.test.name}
    
              6. Key Vault Details:
       - Name: ${module.key_vault.name}
       - URI: ${module.key_vault.vault_uri}
       - SKU: ${module.key_vault.sku_name}
       - Soft Delete: ${var.soft_delete_retention_days} days
       - Network Access: Private only (public access disabled)
  EOT
} 