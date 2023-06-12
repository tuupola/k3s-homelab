# Kubernetes dashboard

```
$ kubectl apply -k bases/dashboard
$ kubectl -n kubernetes-dashboard create token admin-user
$ kubectl port-forward service/kubernetes-dashboard 9443:443 --namespace kubernetes-dashboard
```

https://localhost:9443/


# Traefik dashboard

```
$ kubectl apply -k bases/traefik
```

https://traefik.internal/dashboard/

If for some reason does not work try with port forward instead.

```
$ kubectl port-forward service/traefik-dashboard 9000:9000 --namespace kube-system
```

http://localhost:9000/dashboard/

# Whoami

```
$ kubectl apply -k bases/whoami
$ curl --include http://whoami.internal/foo
$ curl --include --insecure https://whoami.internal/bar
```