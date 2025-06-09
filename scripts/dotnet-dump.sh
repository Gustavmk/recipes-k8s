1. Defina as variáveis do pod que vc quer exportar um **dotnet-dump**:

```bash
export pod_namespace=production-hangfire
export pod_name=hang-sistemaacademia-prod-fd94fb799-2v4hr
```

2. `kubectl exec -n $pod_namespace -it "pod/$pod_name" -- /bin/bash`
3. Instale o **dotnet-dump** no pod e identifique o processo do runtime.

cd /tmp ; apt update && apt install curl -y ; curl -L -o dotnet-dump https://aka.ms/dotnet-dump/linux-x64 
chmod 777 ./dotnet-dump ; export DOTNET_BUNDLE_EXTRACT_BASE_DIR="/tmp/bundle_extract" ; ./dotnet-dump ps
   
4. `./dotnet-dump collect -p 1`
5. `gzip core_<timestamp>`
6. `exit`
7. `kubectl cp -n $pod_namespace "$pod_name:/tmp/core_<timestamp>.gz" ./core_<timestamp>.gz`
