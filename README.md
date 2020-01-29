## Azure RedHat OpenShift 4.3

This template will deploy a ARO 4.3 cluster with full customization capabilities. 
To begin with, register the ARO 4.3 provider in your subscription:

```
az provider register -n Microsoft.RedHatOpenShift --wait
```

You require an Azure service principal and the ARO 4.3 Resource Provider service principal in order to use this template. The template expects the "Object ID" of the service principal. Below are the commands necessary to create this service principal and get its object id.

```
az ad sp create-for-rbac --name <appName>
az ad sp list --all --query "[?appDisplayName=='<appName>'].{name: appDisplayName, objectId: objectId}"
```

And to obtain the ARO 4.3 RP service principal object id execute the following command. WARNING! This process may take a while if you have a large number of service principals. Alternatively you can search for the object id through the portal by navigating to Azure Active Directory and then Enterprise Applications and searching for "Azure Red Hat OpenShift RP":

```
az ad sp list --all --query "[?appDisplayName=='Azure Red Hat OpenShift RP'].{name: appDisplayName, objectId: objectId}"
```
To setup SSO on OpenShift you can use the same SP that you created (Not the RP SP). You will need the AppId(ClientId), the App Secret, and the AAD Tenant Id.

The SSO Setup for AAD and Openshift is as follows:

Name: AAD
ClientID: <AppId>
ClientSecret: <App Secret>
IssuerURL: https://login.microsoftonline.com/<AADTenantID>
Preferred Username: upn

Callback URL to enter into the AAD SP:
https://<cluster-console-url>/oauth2callback/AAD

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fjmo808%2farm-aro43%2fmaster%2Fazuredeploy.json" target="_blank">
  
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png"/>
</a>
