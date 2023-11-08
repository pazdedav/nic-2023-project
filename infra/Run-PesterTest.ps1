# Full
$params = @{
    TemplatePath = 'c:\temp\azuredeploy.json'
    parameters   = 'virtualMachineNamePrefix', 'virtualMachineSize', 'adminUsername', 'virtualNetworkResourceGroup', 'virtualNetworkName', 'adminPassword', 'subnetName'
    variables    = 'nicName', 'publicIpAddressName', 'publicIpAddressSku', 'publicIpAddressType', 'subnetRef', 'virtualMachineName', 'vnetId'
    resources    = 'Microsoft.Compute/virtualMachines', 'Microsoft.Network/networkInterfaces', 'Microsoft.Network/publicIpAddresses'
    outputs      = 'adminUsername'
}

./Test.ARMTemplate.ps1 @params

# Limited test
$params = @{
    TemplatePath = './deploy-vm.json'
    resources    = 'Microsoft.Storage/storageAccounts', 'Microsoft.Network/publicIPAddresses', 'Microsoft.Network/networkSecurityGroups', 'Microsoft.Network/virtualNetworks', 'Microsoft.Network/networkInterfaces', 'Microsoft.Compute/virtualMachines', 'Microsoft.Compute/virtualMachines/extensions'
}
./Test.ARMTemplate.ps1 @params