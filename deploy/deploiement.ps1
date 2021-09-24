$suffixe=Read-host "Entrez le suffixe de déploiement utiliser" 
$rgname="DemoApim-"+ $suffixe
$planname="DemoApim-Plan"
$planSku="S1"
$api1name="demoapimapi"+ $suffixe
$api1zipFile=$api1name+ ".zip"
$api2name="demoapimotherapi"+ $suffixe
$api2zipFile=$api2name+".zip"
$location="francecentral"

$apimname="DemoApim-"+ $suffixe
$apimPublisherName="DemoAPIM" # TO REPLACE
$apimPublisherEmail="myemail@myemaildomain.com" # TO REPLACE

####################################################################################
# Compilation des applications
Remove-Item $api1zipFile  -Force
dotnet publish ..\src\DemoApimAPI\DemoApimAPI.csproj
Compress-Archive -Path ..\src\DemoApimAPI\bin\Debug\netcoreapp3.1\publish\* -DestinationPath $api1zipFile

Remove-Item $api2zipFile  -Force
dotnet publish ..\src\DemoApimOtherAPI\DemoApimOtherAPI.csproj
Compress-Archive -Path ..\src\DemoApimOtherAPI\bin\Debug\netcoreapp3.1\publish\* -DestinationPath $api2zipFile

####################################################################################
# switch to the selected deployment solution
#az account set --subscription $sub

############################## GROUPE DE RESSOURCE #################################
write-host  Création du groupe de ressource : $rgname 
az group create -n $rgname -l $location

######################### SERVICE PLAN ET APP SERVICE ###########################
write-host  Création du service plan : $planname
az appservice plan create -g $rgname -n $planname -l $location --sku $planSku

az webapp create -g $rgname -p $planname -n $api1name
#az webapp config appsettings set -g $rgname -n $webappname --settings  CatalogItemsServiceUrl=$catalogserviceurl  MaxItemsOnHomePage=12 ApplicationInsightsAgent_EXTENSION_VERSION="~2" 
az webapp deployment source config-zip -g $rgname -n $api1name --src $api1zipFile
az webapp restart -g $rgname -n $api1name

write-host  Création API $api2name
az webapp create -g $rgname -p $planname -n $api2name 
#az webapp config appsettings set -g $rgname -n $catalogservicename --settings UseCosmosDb=false AccountKey=$accountkey AccountName=$accountname CosmosDbConnectionString=$cosmosdbconnectionstring CatalogName=$tablename ContainerName=$containername  MaxItems=25 MaxItemsOnHomePage=6 ApplicationInsightsAgent_EXTENSION_VERSION="~2" 
az webapp deployment source config-zip -g $rgname -n $api2name --src .\$api2zipFile
az webapp restart -g $rgname -n $api2name


##################################################################################
#Cleaning temporary deployment artefact
Remove-Item $api1zipFile
Remove-Item $api2zipFile

# Memento
Write-Host "*** WebApps :"
az webapp list -g $rgname -o table


####################################################################################
# API Management Dev Edition deployment (default)
az apim create --name $apimname --resource-group $rgname --publisher-name $apimPublisherName --publisher-email $apimPublisherEmail  --no-wait
az apim show --name $apimname --resource-group $rgname --output table
Write-Host "--> WAIT UNTIL STATUS IS 'Online' (can take up to 30min)"
Write-Host "RUN TO CHECK: az apim show --name " $apimname " --resource-group " $rgname " -o table"