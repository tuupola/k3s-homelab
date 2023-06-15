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

# Rancher

Rancher is installed using Helm which I am not a big fan of. Rancher also require Kubernetes 1.24.x or older.

```
$ helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
$ kubectl create namespace cattle-system
$ helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.internal \
  --set bootstrapPassword=admin \
  --set ingress.includeDefaultExtraAnnotations=false \
  --set tls=external
$ kubectl -n cattle-system rollout status deploy/rancher
```

https://rancher.internal/

# Whoami

```
$ kubectl apply -k bases/whoami
$ curl --include http://whoami.internal/foo
$ curl --include --insecure https://whoami.internal/bar
```