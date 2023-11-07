module keyVault '../key-vault.bicep' = {
  name: 'keyVault'
  params: {
    keyVaultName: 'akv01'
    location: 'eastus'
  }
}
