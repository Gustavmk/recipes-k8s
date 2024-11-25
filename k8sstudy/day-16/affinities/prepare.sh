k label nodes kind-worker region=sa-east-1 --overwrite
k label nodes kind-worker2 region=sa-east-1 --overwrite
k label nodes kind-worker3 region=sa-east-2 --overwrite
k label nodes kind-control-plane region=sa-east-2 --overwrite
k get nodes -L regio