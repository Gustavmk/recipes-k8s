O que são Tolerations?
Agora que entendemos como os Taints funcionam e como eles influenciam o agendamento de Pods nos Nodes, vamos mergulhar no mundo das Tolerations. As Tolerations são como o "antídoto" para os Taints. Elas permitem que um Pod seja agendado em um Node que possui um Taint específico. Em outras palavras, elas "toleram" as Taints.

Vamos voltar ao nosso cluster da Strigus para entender melhor como isso funciona.

Imagine que temos um workload crítico que precisa ser executado em um Node com GPU. Já marcamos nossos Nodes com GPU com a label gpu=true, e agora vamos usar Tolerations para garantir que nosso Pod possa ser agendado nesses Nodes. Isso não faz com que o Pod seja agendado nesses Nodes, mas permite que ele seja agendado nesses Nodes. Entendeu a diferença?

Primeiro, vamos criar um Taint no Node strigus-worker1, que possui uma GPU.

kubectl taint nodes strigus-worker1 gpu=true:NoSchedule

Com esse Taint, estamos dizendo que nenhum Pod será agendado nesse Node, a menos que ele tenha uma Toleration específica para a Taint gpu=true.


Onde:

- key é a chave do Taint que queremos tolerar.
- operator é o operador que queremos utilizar. Nesse caso, estamos utilizando o operador Equal, que significa que o valor do Taint precisa ser igual ao valor da Toleration.
- value é o valor do Taint que queremos tolerar.
- effect é o efeito do Taint que queremos tolerar. Nesse caso, estamos utilizando o efeito NoSchedule, que significa que o Kubernetes não irá agendar nenhum Pod nesse Node a menos que ele tenha uma Toleration correspondente.

Isso demonstra o poder das Tolerations em combinação com os Taints. Podemos controlar com precisão onde nossos Pods são agendados, garantindo que workloads críticos tenham os recursos que necessitam.

Mas lembrando mais uma vez, as Tolerations não fazem com que o Pod seja agendado nesses Nodes, mas permite que ele seja agendado nesses Nodes.

Então, caso você queira garantir que determinado Pod seja executado em determinado Node, você precisa utilizar o conceito de Affinity, que veremos agora.

