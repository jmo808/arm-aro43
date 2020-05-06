To setup SSO on OpenShift you can use the same SP that you created. You will need the AppId(ClientId), the App Secret, and the AAD Tenant Id. In order to have both B2B AAD users and native AAD users be created properly in OpenShift you will first need to add the optional email claim on the app registration(service principal). 

![Image of Optional Claim Setup](https://github.com/jmo808/arm-aro43/raw/master/upnClaim.png)

**NOTE**: If you created a separate SSO Service Principal in a different Azure AD Tenant than the cluster service principal then you will need to update the reply URL manually through the portal.

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
randomString=$(head /dev/urandom | tr -dc a-z0-9 | head -c 4 ; echo '')
ocOpenidSecret="openid-client-secret-${randomString}"

wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/4.3.1/openshift-client-linux-4.3.1.tar.gz
wget https://raw.githubusercontent.com/jmo808/arm-aro43/master/oidcCR.yaml
tar -xf openshift-client-linux-4.3.1.tar.gz
./oc login $apiServer -u kubeadmin -p $kubelogin --insecure-skip-tls-verify=true
./oc create secret generic $ocOpenidSecret --from-literal=clientSecret=$clientSecret -n openshift-config
sed -i "s/<clientId>/$clientId/" oidcCR.yaml
sed -i "s/<tenantId>/$tenantId/" oidcCR.yaml
sed -i "s/<secretname>/$ocOpenidSecret/" oidcCR.yaml
./oc apply -f oidcCR.yaml

az ad app update --id $clientId --reply-urls $oauthCallbackURL
```
