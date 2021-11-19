#
# ⛩ Service connection 2 🔐  KV
#
module "DEV-TLS-CERT-SERVICE-CONN" {
  depends_on = [azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v2.0.3"
  providers = {
    azurerm = azurerm.dev
  }

  project_id        = azuredevops_project.project.id
  renew_token       = local.tlscert_renew_token
  name              = format("%s-d-tls-cert", local.prefix)
  tenant_id         = module.secrets.values["TENANTID"].value
  subscription_id   = module.secrets.values["DEV-SUBSCRIPTION-ID"].value
  subscription_name = var.dev_subscription_name

  credential_subcription              = var.dev_subscription_name
  credential_key_vault_name           = local.dev_key_vault_name
  credential_key_vault_resource_group = local.dev_key_vault_resource_group
}

data "azurerm_key_vault" "kv_dev" {
  provider            = azurerm.dev
  name                = format("%s-d-kv", local.prefix)
  resource_group_name = format("%s-d-sec-rg", local.prefix)
}

resource "azurerm_key_vault_access_policy" "DEV-TLS-CERT-SERVICE-CONN_kv_dev" {
  provider     = azurerm.dev

  key_vault_id = data.azurerm_key_vault.kv_dev.id
  tenant_id    = module.secrets.values["TENANTID"].value
  object_id    = module.DEV-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

module "UAT-TLS-CERT-SERVICE-CONN" {
  depends_on = [azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v2.0.3"
  providers = {
    azurerm = azurerm.uat
  }

  project_id        = azuredevops_project.project.id
  renew_token       = local.tlscert_renew_token
  name              = format("%s-u-tls-cert", local.prefix)
  tenant_id         = module.secrets.values["TENANTID"].value
  subscription_id   = module.secrets.values["UAT-SUBSCRIPTION-ID"].value
  subscription_name = var.uat_subscription_name

  credential_subcription              = var.uat_subscription_name
  credential_key_vault_name           = local.uat_key_vault_name
  credential_key_vault_resource_group = local.uat_key_vault_resource_group
}

data "azurerm_key_vault" "kv_uat" {
  provider            = azurerm.uat
  name                = format("%s-u-kv", local.prefix)
  resource_group_name = format("%s-u-sec-rg", local.prefix)
}

resource "azurerm_key_vault_access_policy" "UAT-TLS-CERT-SERVICE-CONN_kv_uat" {
  provider     = azurerm.uat
  key_vault_id = data.azurerm_key_vault.kv_uat.id
  tenant_id    = module.secrets.values["TENANTID"].value
  object_id    = module.UAT-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}

module "PROD-TLS-CERT-SERVICE-CONN" {
  depends_on = [azuredevops_project.project]
  source     = "git::https://github.com/pagopa/azuredevops-tf-modules.git//azuredevops_serviceendpoint_azurerm_limited?ref=v2.0.3"
  providers = {
    azurerm = azurerm.prod
  }

  project_id        = azuredevops_project.project.id
  renew_token       = local.tlscert_renew_token
  name              = format("%s-p-tls-cert", local.prefix)
  tenant_id         = module.secrets.values["TENANTID"].value
  subscription_id   = module.secrets.values["PROD-SUBSCRIPTION-ID"].value
  subscription_name = var.prod_subscription_name

  credential_subcription              = var.prod_subscription_name
  credential_key_vault_name           = local.prod_key_vault_name
  credential_key_vault_resource_group = local.prod_key_vault_resource_group
}

data "azurerm_key_vault" "kv_prod" {
  provider            = azurerm.prod
  name                = format("%s-p-kv", local.prefix)
  resource_group_name = format("%s-p-sec-rg", local.prefix)
}

resource "azurerm_key_vault_access_policy" "PROD-TLS-CERT-SERVICE-CONN_kv_prod" {
  provider     = azurerm.prod
  key_vault_id = data.azurerm_key_vault.kv_prod.id
  tenant_id    = module.secrets.values["TENANTID"].value
  object_id    = module.PROD-TLS-CERT-SERVICE-CONN.service_principal_object_id

  certificate_permissions = ["Get", "Import"]
}