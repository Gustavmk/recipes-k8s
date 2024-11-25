# O que são Affinity e Antiaffinity?

Affinity e Antiaffinity são conceitos que permitem que você defina regras para o agendamento de Pods em determinados Nodes. Com eles você pode definir regras para que Pods sejam agendados em Nodes específicos, ou até mesmo para que Pods não sejam agendados em Nodes específicos.

Vamos entender como isso funciona na prática.

Você se lembra que adicionamos a label gpu=true nos Nodes que possuem GPU? Então, vamos utilizar essa label para garantir que o nosso Pod seja agendado somente neles. Para isso, vamos utilizar o conceito de Affinity.

Vamos criar um Deployment com 5 réplicas do Nginx com a seguinte configuração:

```md
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 5
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: gpu
                operator: In
                values:
                - "true"
```

Onde:

- affinity é o início da configuração de Affinity.
- nodeAffinity é o conceito de Affinity para Nodes.
- requiredDuringSchedulingIgnoredDuringExecution é usado para indicar que o Pod só pode ser agendado em um Node que atenda aos requisitos de Affinity, está falando que essa regra é obrigatória no momento do agendamento do Pod, mas que pode ser ignorada durante a execução do Pod.
- nodeSelectorTerms é usado para indicar os termos de seleção de Nodes, que será usado para selecionar os Nodes que atendem aos requisitos de Affinity.
- matchExpressions é usado para indicar as expressões de seleção de Nodes, ou seja, o nome da label, o operador e o valor da label.
- key é o nome da label que queremos utilizar para selecionar os Nodes.
- operator é o operador que queremos utilizar. Nesse caso, estamos utilizando o operador In, que significa que o valor da label precisa estar dentro dos valores que estamos informando.
- values é o valor da label que queremos utilizar para selecionar os Nodes.


## O Antiaffinity?

O Antiaffinity é o conceito contrário ao Affinity. Com ele você pode definir regras para que Pods não sejam agendados em Nodes específicos.

