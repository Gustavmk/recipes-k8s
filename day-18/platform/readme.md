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