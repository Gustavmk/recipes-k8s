# Taints, Tolerations, Affinity e Antiaffinity

Hoje é dia de falar sobre Taints, Tolerations, Affinity e Antiaffinity. Vamos entender como eles podem nos ajudar no dia-a-dia na administração de um cluster Kubernetes.

Com eles podemos isolar workloads, garantir que Pods sejam agendados em Nodes específicos e até mesmo evitar que Pods sejam agendados em determinados Nodes do cluster.

## O Nosso cluster de exemplo

Para que possamos ter alguns exemplos mais divertido, vamos imaginar que temos um empresa chamada Strigus, e que essa empresa tem o seu cluster Kubernetes de produção composto por 08 nodes, sendo 4 control planes e 4 workers. Ele está dividido em duas regiões, São Paulo e Salvador, chamadas de strigus-br-sp e strigus-br-ssa respectivamente. E cada região tem dois datacenters, strigus-sp-1 e strigus-sp-2 em São Paulo e strigus-br-ssa-1 e strigus-br-ssa-2 em Salvador.

**SP**
- strigus-sp-1
  - strigus-control-plane1
  - strigus-worker3
- strigus-sp-2
  - strigus-control-plane4
  - strigus-worker1

**Salvaodor**
- strigus-ssa-1
  - strigus-control-plane2
  - strigus-worker2
- strigus-ssa-2
  - strigus-control-plane3
  - strigus-worker4

A primeira coisa que precisamos fazer é criar as Labels em nossos Nodes. Para isso, vamos utilizar o comando kubectl label nodes e vamos adicionar as labels region e datacenter em cada um dos nossos Nodes.

```bash
kubectl label nodes strigus-control-plane1 region=strigus-br-sp datacenter=strigus-br-sp-1
kubectl label nodes strigus-control-plane2 region=strigus-br-ssa datacenter=strigus-br-ssa-1
kubectl label nodes strigus-control-plane3 region=strigus-br-ssa datacenter=strigus-br-ssa-2
kubectl label nodes strigus-control-plane4 region=strigus-br-sp datacenter=strigus-br-sp-2
kubectl label nodes strigus-worker1 region=strigus-br-sp datacenter=strigus-br-sp-2
kubectl label nodes strigus-worker2 region=strigus-br-ssa datacenter=strigus-br-ssa-1
kubectl label nodes strigus-worker3 region=strigus-br-sp datacenter=strigus-br-sp-1
kubectl label nodes strigus-worker4 region=strigus-br-ssa datacenter=strigus-br-ssa-2
```

Pronto, as nossas labels estão criadas, com isso já conseguimos ter um pouco mais de organização em nosso cluster.

## Labels especiais

Mas ainda não acabou o nosso trabalho, cada uma das regiões possui um node com um hardware especial, que é uma GPU. Vamos criar uma label para identificar esses nodes, mas por enquanto é somente para identificar, não vamos fazer nada com eles ainda.

kubectl label nodes strigus-worker1 gpu=true
kubectl label nodes strigus-worker4 gpu=true

Pronto, por enquanto isso resolve, mas com certeza precisaremos adicionar mais labels em nossos nodes no futuro, mas por enquanto isso já resolve o nosso problema.

Caso eu queira remover alguma Label, basta utilizar o comando `kubectl label nodes strigus-control-plane1 region-` e a label será removida.

