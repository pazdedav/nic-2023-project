
param storageAccountName string = 'myStorageAccount'

@secure()
param adminPassword string = 'HardcodedPassword'

@secure()
param secureParam string

resource stg 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  location: 'westus'
  name: 'store${toLower(time)}'
}

#disable-next-line outputs-should-not-contain-secrets
output badResult string = 'this is the value ${secureParam}'
