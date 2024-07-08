# RBAC


## Criação de acessos

Certificate or Token? 

Temos duas formas de fazer isso, a primeira e mais antiga é através da criação de um Token de acesso, e a que iremos abordar na sequência é através da criação de um certificado. O Token é mais utilizado para dar acesso a um ServiceAccount, que é um usuário que não é humano. Por exemplo, podemos ter um ServiceAccount para o Prometheus poder coletar métricas do cluster, ou um ServiceAccount para o Fluentd poder coletar os logs do cluster. E podemos ter um User para um usuário humano, como por exemplo, o usuário developer que iremos criar.

## Passos para criação de certificate

```bash
openssl genrsa -out developer.key 2048      # cria private key 

openssl req -new -key developer.key -out developer.csr -subj "/CN=developer" # Cria CSR do certificado

cat developer.csr | base64 | tr -d '\n'

# Copie o texto em base64 para criação do CSR 

kubectl apply -f user-developer.yml

kubectl describe csr developer

kubectl certificate approve developer

k get csr developer -o jsonpath='{.status.certificate}' | base64 --decode > developer-k8s.crt  # com o retorno do certificado, podemos utilizar esse certificado para acesso ao Cluster.
```

## Criando uma role

A definição da Role consiste em um arquivo onde definimos quais são as permissões que o usuário terá no cluster, e para quais recursos ele terá acesso. Dentro da Role é onde definimos:

1. Qual é o namespace que o usuário terá acesso.
2. Quais apiGroups o usuário terá acesso.
3. Quais recursos o usuário terá acesso.
4. Quais verbos o usuário terá acesso.


## apiGroups

São os grupos de recursos do Kubernetes, que são divididos em core e named, você pode consultar todos os grupos de recursos do Kubernetes através do comando kubectl api-resources.

- `kubectl api-resources -o wide` listará todos os recursos disponíveis para delegação 
- Resources em "v1" são recursos cores do Cluster.
- `kubectl api-resources --namespaced=false` -> todos recursos que não são vinculados a um namespace. 
- `kubectl api-resources --namespaced=false | grep role` -> Abrangem o cluster inteiro por isso são namespaced=false

Onde a primeira coluna é o nome do recurso, a segunda coluna é o nome abreviado do recurso, a terceira coluna é a versão da API que o recurso está, a quarta coluna indica se o recurso é ou não Namespaced, e a quinta coluna é o tipo do recurso.

## Recursos

São os recursos do Kubernetes, que são divididos em core e named, você pode consultar todos os recursos do Kubernetes através do comando kubectl api-resources.


## Verbos

Os verbos são divididos em:

create: Permite que o usuário crie um recurso.
delete: Permite que o usuário delete um recurso.
deletecollection: Permite que o usuário delete uma coleção de recursos.
get: Permite que o usuário obtenha um recurso.
list: Permite que o usuário liste os recursos.
patch: Permite que o usuário atualize um recurso.
update: Permite que o usuário atualize um recurso.
watch: Permite que o usuário acompanhe as alterações de um recurso.


```bash
# criando a role

k apply -f rbac-developer.yml           

k describe role -n dev developer 

# Fazendo vinculo da role para o user
k apply -f rbac-role-binding.yml 
k get rolebindings.rbac.authorization.k8s.io -n dev developer
k describe rolebindings.rbac.authorization.k8s.io -n dev developer       

```

### No arquivo acima, estamos definindo as seguintes informações:

- apiVersion: Versão da API que estamos utilizando para criar o nosso usuário.
- kind: Tipo do recurso que estamos criando, no caso, um RoleBinding.
- metadata.name: Nome da nossa RoleBinding.
- metadata.namespace: Namespace que a nossa RoleBinding será criada.
- subjects: Usuários que terão acesso a Role.
- subjects.kind: Tipo do usuário, que no caso é User.
- subjects.name: Nome do usuário, que no caso é developer.
- roleRef: Referência da Role que o usuário terá acesso.
- roleRef.kind: Tipo da Role, que no caso é Role.
- roleRef.name: Nome da Role, que no caso é developer.
- roleRef.apiGroup: Grupo de recursos da Role, que no caso é rbac.authorization.k8s.io.

### Adicionado certificado ao kubeconfig

```bash
# O comando kubectl config set-credentials é utilizado para adicionar um novo usuário no kubeconfig, e ele recebe os seguintes parametros:
kubectl config set-credentials developer --client-certificate=developer-k8s.crt --client-key=developer.key --embed-certs=true
# --client-certificate: Caminho do certificado do usuário.
# --client-key: Caminho da chave do usuário.
# --embed-certs: Indica se o certificado deve ser embutido no kubeconfig.

# Agora precisamos criar um contexto para o nosso usuário, para isso, vamos utilizar o comando kubectl config set-context:
kubectl config set-context developer --cluster=kind-kind --namespace=dev --user=developer

# Para que você possa pegar os nomes do cluster, basta utilizar o comando kubectl config get-clusters, assim você poderá pegar o nome do cluster que você quer utilizar.
kubectl config get-clusters,
```


