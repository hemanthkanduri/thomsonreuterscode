
# Tag values for resources
$tags = @{
    environment = 'Local'
    department = 'IT'
    costCenter = '12345'
}
# Define new parameter values
$location = 'eastus2'
$acrName = 'akkadiaacrlocaltest'
$acrSku = 'Basic'  # Example: Basic or Standard

# Parameter values for Keyvault
$keyVaultName = 'akv-local-001'
$skuName = 'standard'

#Parameter values for AKS
$clusterName = 'aks-akkadia-local-cluster'
$dnsPrefix = ''
$osDiskSizeGB = 128
$agentCount = 2
$agentVMSize = 'standard_d2s_v3'
$linuxAdminUsername = 'aksadmin'
$sshRSAPublicKey = 'customerdms@#2024'

# Parameters values for PostgreSQl

$secret = "dbadmin@2020"

$username = 'akkadiaadmin'
$adminpassword = $secret
$serverName = 'akkadia-postgressql-local'
$serverEdition = 'GeneralPurpose'
$skuSizeGB = 128
$dbInstanceType = 'Standard_D4ds_v4'
$haMode = 'ZoneRedundant'
$availabilityZone = '1'
$version = '12'


# Read the content of the Bicep file
$bicepContent = Get-Content -Path './Infrastructure/local/local-deployment.bicepparam' -Raw

# Replace parameter values
$bicepContent = $bicepContent -replace 'param location = ''.*''', "param location = '$location'"
$bicepContent = $bicepContent -replace 'param acrName = ''.*''', "param acrName = '$acrName'"
$bicepContent = $bicepContent -replace 'param acrSku = ''.*''', "param acrSku = '$acrSku'"
#Keyvault
$bicepContent = $bicepContent -replace 'param keyVaultName = ''.*''', "param keyVaultName = '$keyVaultName'"
$bicepContent = $bicepContent -replace 'param skuName = ''.*''', "param skuName = '$skuName'"
# AKS
$bicepContent = $bicepContent -replace 'param clusterName = ''.*''', "param clusterName = '$clusterName'"
$bicepContent = $bicepContent -replace 'param dnsPrefix = ''.*''', "param dnsPrefix = '$dnsPrefix'"
$bicepContent = $bicepContent -replace '(?<=osDiskSizeGB = )\d+', $osDiskSizeGB
$bicepContent = $bicepContent -replace '(?<=agentCount = )\d+', $agentCount
$bicepContent = $bicepContent -replace 'param agentVMSize = ''.*''', "param agentVMSize = '$agentVMSize'"
$bicepContent = $bicepContent -replace 'param linuxAdminUsername = ''.*''', "param linuxAdminUsername = '$linuxAdminUsername'"
$bicepContent = $bicepContent -replace 'param sshRSAPublicKey = ''.*''', "param sshRSAPublicKey = '$sshRSAPublicKey'"
# PostgreSQL
$bicepContent = $bicepContent -replace 'param username = ''.*''', "param username = '$username'"
$bicepContent = $bicepContent -replace 'param adminpassword = ''.*''', "param adminpassword = '$adminpassword'"
$bicepContent = $bicepContent -replace 'param serverName = ''.*''', "param serverName = '$serverName'"
$bicepContent = $bicepContent -replace 'param serverEdition = ''.*''', "param serverEdition = '$serverEdition'"
$bicepContent = $bicepContent -replace '(?<=skuSizeGB = )\d+', $skuSizeGB
$bicepContent = $bicepContent -replace 'param dbInstanceType = ''.*''', "param dbInstanceType = '$dbInstanceType'"
$bicepContent = $bicepContent -replace 'param haMode = ''.*''', "param haMode = '$haMode'"
$bicepContent = $bicepContent -replace 'param availabilityZone = ''.*''', "param availabilityZone = '$availabilityZone'"
$bicepContent = $bicepContent -replace 'param version = ''.*''', "param version = '$version'"

# Check if $tags is not null and has elements before iterating

foreach ($tag in $tags.GetEnumerator()) {
    $tagName = $tag.Key
    $tagValue = $tag.Value
    $bicepContent = $bicepContent -replace "(?<=${tagName}:\s*)'[^']*'", "'$tagValue'"
}

# replace the parameter values for Keyvault

# Write the updated content back to the Bicep file
$bicepContent | Set-Content -Path './Infrastructure/local/local-deployment.bicepparam' -Force
