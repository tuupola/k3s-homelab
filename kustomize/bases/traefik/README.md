
# Self generated default cert

To avoid constantly approving Traefik generated certs you can define a [default certificate](https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/#kind-tlsstore) using a TLSStore. Kustomize does not handle TLSStores so you need to create the secret manually.

```
$ openssl req -x509 -nodes -days 365 -subj "/CN=internal" -addext "subjectAltName = DNS:*.internal" -newkey rsa:2048 -keyout default.key -out default.crt

$ kubectl create secret generic default-cert --from-file=tls.crt=./default.crt --from-file=tls.key=./default.key --namespace kube-system
```

Deploy as usual.

```
$ kubectl diff -k .
$ kubectl apply -k .
```