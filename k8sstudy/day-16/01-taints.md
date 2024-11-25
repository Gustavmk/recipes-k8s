## Taints 

Taints são marcações especificas para nodes. 
Todo control plane já vem com noSchedule por padrão

Com a adição da taint 
`k taint node kind-worker3 manutnecao=true:NoExecute`

Para forçar um rebalance do deployment após a adição da taint 'NoExecute' execute `k rollout restart deployment nginx`.

k taint node strigus-worker4 gpu=true:NoSchedule

Taints são "manchas" ou "marcações" aplicadas aos Nodes que os marcam para evitar que certos Pods sejam agendados neles. Essa é uma forma bastante comum de isolar workloads em um cluster Kubernetes, por exemplo em momentos de manutenção ou quando você tem Nodes com recursos especiais, como GPUs.

Os Taints são aplicados nos Nodes e podem ter um efeito de NoSchedule, PreferNoSchedule ou NoExecute. O efeito NoSchedule faz com que o Kubernetes não agende Pods nesse Node a menos que eles tenham uma Toleration correspondente. O efeito PreferNoSchedule faz com que o Kubernetes tente não agendar, mas não é uma garantia. E o efeito NoExecute faz com que os Pods existentes sejam removidos se não tiverem uma Toleration correspondente.

Agora vamos entender isso na prática!

Em nosso primeiro exemplo vamos conhecer a Taint NoSchedule. Para que você possa configurar um Taint em um Node, você utiliza o comando kubectl taint. Por exemplo:

kubectl taint nodes strigus-worker1 key=value:NoSchedule


Diferente do efeito NoSchedule, o efeito NoExecute faz com que os Pods existentes sejam removidos se não tiverem uma Toleration correspondente.