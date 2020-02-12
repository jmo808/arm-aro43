To setup SSO on OpenShift you can use the same SP that you created. You will need the AppId(ClientId), the App Secret, and the AAD Tenant Id. 

```
az login
az account set --subscription <ARO 4.3 Cluster Subscription Name or Id>

aroResourceGroup=<ARO RG Name>
aroClusterName=<ARO Cluster Name>
kubelogin=$(az aro list-credentials -g $aroResourceGroup -n $aroClusterName --query kubeadminPassword -o tsv)
clientSecret=<AAD SP Secret>
clientId=<AAD App ID>
tenantId=<AAD Tenant Id of the App Id>
domain=$(az aro show -g $aroResourceGroup -n $aroClusterName --query clusterProfile.domain -o tsv)
location=$(az aro show -g $aroResourceGroup -n $aroClusterName --query location -o tsv)
apiServer=$(az aro show -g $aroResourceGroup -n $aroClusterName --query apiserverProfile.url -o tsv)
oauthCallbackURL=https://oauth-openshift.apps.$domain.$location.aroapp.io/oauth2callback/AAD

wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-4.3.1.tar.gz
wget https://raw.githubusercontent.com/jmo808/arm-aro43/master/oidcCR.yaml
tar -xf openshift-client-linux-4.3.1.tar.gz
./oc login $apiServer -u kubeadmin -p $kubelogin --insecure-skip-tls-verify=true
./oc create secret generic openid-client-secret-34 --from-literal=clientSecret=$clientSecret -n openshift-config
sed -i "s/<clientId>/$clientId/" oidcCR.yaml
sed -i "s/<tenantId>/$tenantId/" oidcCR.yaml
./oc apply -f oidcCR.yaml

az ad app update --id $clientId --reply-urls $oauthCallbackURL
```
