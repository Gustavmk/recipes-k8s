# usuário para gestão de cluster

openssl genrsa -out platform.key 2048

openssl req -new -key platform.key -out platform.csr -subj "/CN=platform/O=platform"

cat platform.csr | base64 | tr -d '\n'

k apply -f user-platform.yml 

k get csr

k certificate approve platform 

k get clusterrole  # lista todas clusterRole nativas

k apply -f platform/rbac-platform.yml

k apply -f platform/rbac-role-binding.yml


# TOKEN

```bash
TOKEN=$(k get secret sa-cluster -o jsonpath='{.data.token}' | base64 -d)
kubectl config set-credentials cluster-sa-token --token=$TOKEN

k config set-context cluster-sa --cluster=kind-kind --namespace default --user=cluster-sa-token

# k config get-users  - kubectl config get-clusters
``` 
