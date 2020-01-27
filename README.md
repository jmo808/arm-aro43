## Azure RedHat OpenShift 4.3

This template will deploy a ARO 4.3 cluster with full customization capabilities.

You require an Azure service principal in order to use this template. The template expects the "Object ID" of the service principal. Below are the commands necessary to create this service principal and get its object id.

```
az ad sp create-for-rbac --name <appName>
az ad sp list --show-mine --query "[?appDisplayName=='<appName>'].{name: appDisplayName, objectId: objectId}"
```

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjmo808%2farm-aro43%2fmaster%2Fazuredeploy.json" target="_blank">
  
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>
