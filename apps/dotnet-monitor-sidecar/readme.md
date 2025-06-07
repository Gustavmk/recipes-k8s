
#### Commands Used In The Video

```bash

#TODO: create kind cluster

kubectl apply -f azurite.yaml 

kubectl apply -f egressmap.yaml

kubectl create configmap dotnet-monitor-triggers --from-file=settings.json
 
dotnet monitor generatekey
kubectl create secret generic apikey --from-literal=Authentication__MonitorApiKey__Subject='...' --from-literal=Authentication__MonitorApiKey__PublicKey='...' --dry-run=client -o yaml > dotnetmonitor-secret.yaml
kubectl apply -f dotnetmonitor-secret.yaml

# Check
kubectl get configmaps
kubectl get secrets

kubectl apply -f deploy.yaml

# Validate
kubectl get pods
kubectl logs <pod-name> monitor
kubectl get pods


kubectl exec -it $POD_AKS -c monitor -- /bin/sh
curl -v http://localhost:8081/Invalid

```

### TESTS


#TODO: explain this section

```bash

kubectl port-forward $(k get pod -l app=azurite) 10000 &
kubectl port-forward $(k get pod -l app=akstest) 52323 &
kubectl port-forward $(k get pod -l app=akstest) 8081:8080 &

TOKEN_API="<token from dotnet monitor>"

# Get Process
curl -v -H "Authorization: Bearer $TOKEN_API" http://localhost:52323/processes

# Get Metrics
curl -v -H "Authorization: Bearer $TOKEN_API" http://localhost:52323/metrics

# Create dump using egressProvider configured
curl -v -H "Authorization: Bearer $TOKEN_API" http://localhost:52323/gcdump?egressProvider=monitorBlob
curl -v -H "Authorization: Bearer $TOKEN_API" http://localhost:52323/gcdump?egressProvider=monitorFile

# Test API 
curl -v http://localhost:8081/Invalid
```

### References

- Dotnet Monitor AKS Tutorial
    - [Video Tutorial For Using Dotnet Monitor As A Sidecar In AKS](https://www.youtube.com/watch?v=3nzZO34nUFQ)
