#!/bin/bash

USER1="developer1"
USER2="developer2"
NAMESPACE="development"

CA_CERT="ca.crt"
CA_KEY="ca.key"

if [[ ! -f "$CA_CERT" || ! -f "$CA_KEY" ]]; then
  echo "Файлы $CA_CERT и $CA_KEY не найдены. Скопируйте их из Minikube."
  exit 1
fi

openssl genrsa -out ${USER1}.key 2048
openssl req -new -key ${USER1}.key -out ${USER1}.csr -subj "/CN=${USER1}/O=developer-group"
openssl x509 -req -in ${USER1}.csr -CA "$CA_CERT" -CAkey "$CA_KEY" -CAcreateserial -out ${USER1}.crt -days 365

openssl genrsa -out ${USER2}.key 2048
openssl req -new -key ${USER2}.key -out ${USER2}.csr -subj "/CN=${USER2}/O=developer-group"
openssl x509 -req -in ${USER2}.csr -CA "$CA_CERT" -CAkey "$CA_KEY" -CAcreateserial -out ${USER2}.crt -days 365

kubectl config set-credentials ${USER1} --client-certificate=${USER1}.crt --client-key=${USER1}.key
kubectl config set-context ${USER1}@${NAMESPACE} --cluster=kubernetes --namespace=${NAMESPACE} --user=${USER1}

kubectl config set-credentials ${USER2} --client-certificate=${USER2}.crt --client-key=${USER2}.key
kubectl config set-context ${USER2}@${NAMESPACE} --cluster=kubernetes --namespace=${NAMESPACE} --user=${USER2}

echo "Пользователи ${USER1} и ${USER2} созданы и добавлены в контекст kubeconfig."
