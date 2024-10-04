NODE_NAME='aks-syspool001-57110861-vmss000003'
kubectl taint nodes $NODE_NAME  maintance=on:NoExecute

kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=$NODE_NAME