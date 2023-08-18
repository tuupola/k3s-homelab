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

Rancher requires Kubernetes 1.24.x or older. Install with either Kustomize or Helm. Latter is the officially supported method but there is too much magic and Helm gives me a headache.

```
$ kubectl apply -k bases/rancher
$ kubectl -n cattle-system rollout status deploy/rancher
```

Or with Helm.

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

Bootstrap user and password is `admin`.

https://rancher.internal/

# Longhorn

Make sure you have installed Longhorn prerequisites first.

```
$ ansible-playbook -v longhorn.yaml
```

```
$ kubectl apply -k bases/longhorn
$ kubectl get pods -n longhorn-system --watch
```

https://longhorn.internal/

# Whoami

```
$ kubectl apply -k bases/whoami
$ curl --include http://whoami.internal/foo
$ curl --include --insecure https://whoami.internal/bar
```