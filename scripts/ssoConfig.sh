#!/bin/bash

./oc login $apiServer -u kubeadmin -p $kubelogin --insecure-skip-tls-verify=true
./oc delete secret openid-client-secret-34 -n openshift-config
./oc create secret generic openid-client-secret-34 --from-literal=clientSecret=$clientSecret -n openshift-config
sed -i "s/<clientId>/$clientId/" oidcCR.yaml
sed -i "s/<tenantId>/$tenantId/" oidcCR.yaml
./oc apply -f oidcCR.yaml
az login --service-principal --username $clientId --password $clientSecret --tenant $tenantId --allow-no-subscriptions
az ad app update --id $clientId --reply-urls $oauthCallbackURL