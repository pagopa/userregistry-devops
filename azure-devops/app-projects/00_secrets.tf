module "secrets" {
  source = "git::https://github.com/pagopa/azurerm.git//key_vault_secrets_query?ref=v1.0.11"

  resource_group = local.prod_key_vault_resource_group
  key_vault_name = local.prod_key_vault_name

  secrets = [
    "DANGER-GITHUB-API-TOKEN",
    "azure-devops-github-ro-TOKEN",
    "azure-devops-github-rw-TOKEN",
    "azure-devops-github-pr-TOKEN",
    "azure-devops-github-EMAIL",
    "azure-devops-github-USERNAME",
    "DOCKER-REGISTRY-PAGOPA-USER",
    "DOCKER-REGISTRY-PAGOPA-TOKEN-RO",
    "TENANTID",
    "DEV-SUBSCRIPTION-ID",
    "UAT-SUBSCRIPTION-ID",
    "PROD-SUBSCRIPTION-ID",
    "dev-usrreg-aks-apiserver-url",
    "dev-usrreg-aks-azure-devops-sa-token",
    "dev-usrreg-aks-azure-devops-sa-cacrt",
    # "uat-usrreg-aks-apiserver-url",
    # "uat-usrreg-aks-azure-devops-sa-token",
    # "uat-usrreg-aks-azure-devops-sa-cacrt",
    # "prod-usrreg-aks-apiserver-url",
    # "prod-usrreg-aks-azure-devops-sa-token",
    # "prod-usrreg-aks-azure-devops-sa-cacrt"
  ]
}
