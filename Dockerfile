FROM microsoft/azure-cli

RUN mkdir scripts \
    && cd scripts \
    && wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux-4.3.0.tar.gz \
    && tar -xf openshift-client-linux-4.3.0.tar.gz

WORKDIR /scripts

COPY scripts .

CMD ./ssoConfig.sh