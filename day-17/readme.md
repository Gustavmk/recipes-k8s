# Algumas anotações

para saber se o seu cluster suporta o network policies execute `kubectl api-versions | grep networking`.

Se você receber a mensagem networking.k8s.io/v1, significa que o seu cluster suporta Network Policies. Se você receber a mensagem networking.k8s.io/v1beta1, significa que o seu cluster não suporta Network Policies.

Se o seu cluster não suportar Network Policies, você pode utilizar o Calico para implementar as Network Policies no seu cluster. Para isso, você precisa instalar o Calico no seu cluster. Você pode encontrar mais informações sobre o Calico [aqui](https://docs.tigera.io/calico/latest/getting-started/kubernetes/).

Outros CNI que suportam Network Policies são o Weave Net e o Cilium, por exemplo.