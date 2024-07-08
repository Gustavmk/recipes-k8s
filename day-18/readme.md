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

- `kubectl api-resources -o wide` listará todos os recursos disponíveis para delegação 
- Resources em "v1" são recursos cores do Cluster.
- `kubectl api-resources --namespaced=false` -> todos recursos que não são vinculados a um namespace. 
- `kubectl api-resources --namespaced=false | grep role` -> Abrangem o cluster inteiro por isso são namespaced=false
