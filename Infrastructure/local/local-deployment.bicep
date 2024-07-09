// Commen parameters for all environments 

param location string
param tags object

// Parameters for ACR
param acrName string
param acrSku string

// parameters for AKV
param keyVaultName string
param skuName string

// parameters for AKS

param clusterName string
param dnsPrefix string

@minValue(0)
@maxValue(1023)
param osDiskSizeGB int = 0

@minValue(1)
@maxValue(50)
param agentCount int

param agentVMSize string 
param linuxAdminUsername string 
param sshRSAPublicKey string

// parameters for Azure postresQL 
param username string

@secure()
param adminpassword string 
param serverName string 
param serverEdition string
param skuSizeGB int
param dbInstanceType string 
param haMode string
param availabilityZone string
param version string

param modulesToDeploy array = []


// Calling ACR main file from infra-modules folder

module containerregistry '../../Infra-modules/ACR/main.bicep' = {
  name:'ACRDeployment'
  params: {
      acrName: acrName
      location:location
      acrSku: acrSku
      acrAdminUserEnabled: true
      tags: tags
    }
  }

// Calling AKV main file from infra-modules folder

  module keyvault '../../infra-modules/AKV/main.bicep' = {
    name: keyVaultName
    params: {
      keyVaultName: keyVaultName
      //objectId: objectId
      //roleName: roleName
      skuName: skuName
      location: location
      tags: tags
    }
  }

// Calling AKS main file from Infra-modules folder

  module aks '../../infra-modules/AKS/main.bicep' = {
    name: clusterName
    params: {
      clusterName: clusterName
      location: location
      dnsPrefix: dnsPrefix
      osDiskSizeGB: osDiskSizeGB
      agentCount: agentCount
      agentVMSize: agentVMSize
      linuxAdminUsername: linuxAdminUsername
      sshRSAPublicKey: sshRSAPublicKey
      tags: tags
    }
  }
// Calling PostgreSQL from Infra-Modules folder

module psql '../../infra-modules/PostgreSQL/main.bicep' = {

  name: serverName
  params:{
    username:username
    adminpassword:adminpassword
    location: location
    serverName: serverName
    serverEdition: serverEdition
    skuSizeGB: skuSizeGB
    dbInstanceType: dbInstanceType
    haMode: haMode
    availabilityZone: availabilityZone
    version: version
    tags: tags

  }
}

// Deploy the selected modules
foreach module in modulesToDeploy {
  module(module)
}
