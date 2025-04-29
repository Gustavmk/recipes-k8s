# Some useful notes for helm

- List helm values from a release

    helm get values releasename -n namespace -o yaml > values.yaml


## Secrets


    kubectl get secret my-secret -o jsonpath='{.data}'


## Storage checks


```bash
kubectl exec -n elastic test-es-elasticsearch-2 -- df -ah   # validate storage consumption on PesrsistentVolume 
``` 


```bash
# monitoring
kubelet_volume_stats_available_bytes{persistentvolumeclaim="your-pvc"}
kubelet_volume_stats_capacity_bytes{persistentvolumeclaim="your-pvc"}
```


## Tests notes and debugs

- Busybox pod

```bash
# Busybox - oneline command
kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh

# Busybox - manifest as pod - ref https://k8s.io/examples/admin/dns/busybox.yaml
kubectl create -f docs/example/pod-busybox.yaml
kubectl exec -ti busybox -- nslookup redis-master-0.redis-headless.redis.svc.cluster.local

# mongo
kubectl run -i --tty mongo-client --rm \
  --image=mongo \
  --restart=Never \
  -- bash
mongosh "<conection string>"
```

## Alpine 
    
A imagem alpine oferece mais flexibilidade para instalação de packges como curl e redis-cli usando apk 

```bash
kubectl run -i --tty --rm alpine-debug --image=alpine --restart=Never -- sh

apk add curl
apk add redis

redis-cli -h redis-svc.namespace.svc.cluster.local ping
```

- SVC

    `kubectl expose deployment/service/replicaset/replicationController/POD MEU_DEPLOYMENT --port=80 --type=NodePort`

- show up metrics form all nodes
    
    `kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"`

- restart metric server or any other deployment
    
    `kubectl rollout restart deployment metrics-server -n kube-system`
