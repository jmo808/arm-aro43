## Azure RedHat OpenShift 4

This template will deploy a ARO 4 cluster with full customization capabilities. 
To begin with, register the ARO 4 provider in your subscription:

```
az provider register -n Microsoft.RedHatOpenShift --wait
```

You will need an Azure service principal in order to use this template. The template expects the "Object ID" of the service principal. Below are the commands necessary to create this service principal and get its object id.

```
az ad sp create-for-rbac --name <appName>
az ad sp list --filter "displayname eq '<appName>'" --query "[?appDisplayName=='<appName>'].{name: appDisplayName, objectId: objectId}"
```

The ARM template also needs to grant the ARO 4 Resource Provider service principal permissions in order to provision and manage clusters. To obtain the ARO 4 RP service principal object id execute the following command.

```
az ad sp list --filter "displayname eq 'Azure Red Hat OpenShift RP'" --query "[?appDisplayName=='Azure Red Hat OpenShift RP'].{name: appDisplayName, objectId: objectId}"
```
[Azure AD SSO Instructions](SSO.md)
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjmo808%2farm-aro43%2faro44%2Fazuredeploy.json" target="_blank">
  
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>
