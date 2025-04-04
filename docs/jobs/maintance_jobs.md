# Maintance Jobs

## Evicted pods

Job to cleanup evicted pods.

### Evicted Pods: Bash Script

See in file [script - evictedpods](k8s-maintance-evictedpods.sh)

### Evicted Pods: Crontab job

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: maintance
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: sa-maitance-cleanup-evicted-pods
  namespace: maintance
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: maitance-cleanup-evicted-pods
rules:
- apiGroups:
    - ""
  resources:
    - pods
  verbs:
  - get
  - watch
  - list
  - delete
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: maitance-cleanup-evicted-pods
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: maitance-cleanup-evicted-pods
subjects:
  - kind: ServiceAccount
    name: sa-maitance-cleanup-evicted-pods
    namespace: maintance
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: cleanup-evicted-pods-job
  namespace: maintance
spec:
  concurrencyPolicy: Allow
  failedJobsHistoryLimit: 5
  successfulJobsHistoryLimit: 1
  suspend: false
  schedule: "*/5 * * * *"
  jobTemplate:
    spec:
      template:
        metadata:
          creationTimestamp: null
        spec:
          serviceAccountName: sa-maitance-cleanup-evicted-pods
          containers:
          - command:
            - kubectl get pods -A --field-selector=status.phase!=Running --template '{{range .items}}kubectl delete pod -n {{.metadata.namespace}} {{.metadata.name}}{{"\n"}}{{end}}' | sh
            image: wernight/kubectl
            imagePullPolicy: Always
            name: kubectl-runner
            terminationMessagePath: /dev/termination-log
            terminationMessagePolicy: File
          dnsPolicy: ClusterFirst
          restartPolicy: OnFailure
          schedulerName: default-scheduler
          terminationGracePeriodSeconds: 30
```
