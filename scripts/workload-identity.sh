githubOrganizationName='pazdedav'
githubRepositoryName='nic-2023-project'

applicationRegistrationDetails=$(az ad app create --display-name 'nic-2023-project')
applicationRegistrationObjectId=$(echo $applicationRegistrationDetails | jq -r '.id')
applicationRegistrationAppId=$(echo $applicationRegistrationDetails | jq -r '.appId')

az ad app federated-credential create \
   --id $applicationRegistrationObjectId \
   --parameters "{\"name\":\"toy-website-test\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:environment:Website\",\"audiences\":[\"api://AzureADTokenExchange\"]}"

az ad app federated-credential create \
   --id $applicationRegistrationObjectId \
   --parameters "{\"name\":\"toy-website-test-branch\",\"issuer\":\"https://token.actions.githubusercontent.com\",\"subject\":\"repo:${githubOrganizationName}/${githubRepositoryName}:ref:refs/heads/main\",\"audiences\":[\"api://AzureADTokenExchange\"]}"

# Create a resource group
resourceGroupResourceId=$(az group create --name ToyWebsiteTest --location norwayeast --query id --output tsv)

# Grant the application registration access to the resource group
az ad sp create --id $applicationRegistrationObjectId
az role assignment create \
  --assignee $applicationRegistrationAppId \
  --role Contributor \
  --scope $resourceGroupResourceId

# Prepare GH Secrets
echo "AZURE_CLIENT_ID: $applicationRegistrationAppId"
echo "AZURE_TENANT_ID: $(az account show --query tenantId --output tsv)"
echo "AZURE_SUBSCRIPTION_ID: $(az account show --query id --output tsv)"

