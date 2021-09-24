# AzureApimDemo
Demo for Azure API Management

## Prerequisites
AZCLI : Azure Command Line Interface 
DOTNET CORE SDK 3.1 LTS
POWERSHELL

## Deployment
To deploy demo in your default azure subscription, go to 'deploy' folder and run the powerhselle **deploiement.ps1** script. 
It will create :
- 1 AppService plan (S1 sku) 
- 2 web app created in the previous plan. 
- both api project in **src** folder will be compiled and published in the webapps. 
- 1 instance of Azure API Management (default [Developper] sku) 

## Cost 
Deploying this demo will generate cost. Remember to delete the resource group when you finished playin with APIM.
