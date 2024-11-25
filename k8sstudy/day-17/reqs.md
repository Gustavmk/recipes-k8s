# roteiro

- criar cluster eks
- habilitar aws cni
- habilitar network policies
- fazer deploy do nginx

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.5/deploy/static/provider/cloud/deploy.yaml

kubectl get pods -n ingress-nginx

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s


Labels podem ser usadas nas regras de netpol