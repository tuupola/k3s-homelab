# Kubernetes dashboard

```
$ kubectl apply -k bases/dashboard
$ kubectl port-forward service/kubernetes-dashboard 9443:443 --namespace kubernetes-dashboard
$ kubectl -n kubernetes-dashboard create token admin-user
```

https://localhost:9443/
