using './local-deployment.bicep'

param location = 'eastus2'


param tags = {
   environment:'Local'
   department:'IT'
   costCenter:'12345'
}

// parameters for Azure container registry
param acrName = 'akkadiaacrlocaltest'
param acrSku = 'Basic'

// parameters for Azure KeyVault
param keyVaultName = 'akv-local-001'
param skuName = 'standard'

// Parameters for AKS
param clusterName = 'aks-akkadia-local-cluster'
param dnsPrefix = ''
param osDiskSizeGB = 128
param agentCount = 2
param agentVMSize = 'standard_d2s_v3'
param linuxAdminUsername = 'aksadmin'
param sshRSAPublicKey = 'customerdms@#2024'

// parameters for PostgreSQL
param username = 'akkadiaadmin'
param adminpassword = 'dbadmin@2020'
param serverName = 'akkadia-postgressql-local'
param serverEdition = 'GeneralPurpose'
param skuSizeGB = 128
param dbInstanceType = 'Standard_D4ds_v4'
param haMode = 'ZoneRedundant'
param availabilityZone = '1'
param version = '12'
