# usuário para gestão de cluster

k get clusterrole  # lista todas clusterRole nativas

k apply -f platform/rbac-platform.yml

k apply -f platform/rbac-role-binding.yml