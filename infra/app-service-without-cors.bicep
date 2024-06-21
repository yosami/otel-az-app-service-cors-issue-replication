var environmentName = 'nocors'
var appName = 'app-otelpoc-${environmentName}'
var appServicePlanName = 'asp-otelpoc-${environmentName}'
var location = 'westeurope'

@description('The App Service Plan being used for the App Service running the Backend API.')
resource apiAppServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  kind: 'app,linux' // Specifies that it is Linux
  properties: {
    reserved: true // Specifies that it is Linux
  }
  sku: {
    name: 'B1'
    capacity: 1
  }
}

@description('The App Service running the Backend API.')
resource apiAppService 'Microsoft.Web/sites@2022-09-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: apiAppServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|8.0'
      appSettings: []
    }
  }
}
