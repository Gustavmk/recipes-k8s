# Service Account tokens

1. apply na secret
2. get secret `k get secret service-account-example -o jsonpath='{.data.token}' | base64 -d `

3. Creta role
4. create role binding
5. create pod with service account

6. kubectl exec -ti pod-leitor-teste -- sh
7. apk add curl 
8. quando há um service account, existe o mount das secrets em  `/var/run/secrets/kubernetes.io/serviceaccount/token `
9. Para testar o token: 
   1.  curl -k -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" https://kubernetes.default.svc/api/v1/namespaces/default/pods