
# Self-issued certificate

To avoid constantly approving Traefik generated certs you can define a [default certificate](https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/#kind-tlsstore) using a TLSStore. Kustomize does not handle TLSStores so you need to create the secret manually.

## Create a self-issued root CA certificate

Self-issued certificates are CA certificates in which the issuer and subject are the same entity.

```
$ openssl req -x509 -nodes -sha256 -days 3650 -subj "/CN=internal" -newkey rsa:2048 -keyout cacert.key -out cacert.crt
$ openssl x509 -text -noout -in cacert.crt
```

## Create a certificate signed with the root CA

```
$ openssl req -x509 -CA cacert.crt -CAkey cacert.key -nodes -days 365 -subj "/CN=internal" -addext "subjectAltName = DNS:grafana.internal,DNS:rancher.internal,DNS:whoami.internal" -addext "authorityKeyIdentifier = keyid,issuer" -addext "basicConstraints = CA:false" -newkey rsa:2048 -keyout tls.key -out tls.crt
```

Deploy as usual.

```
$ kubectl diff -k .
$ kubectl apply -k .
```

## Note on wildcard certs

Note that wildcard `subjectAltName` will not work.

```
$ openssl req -x509 -CA cacert.crt -CAkey cacert.key -nodes -days 365 -subj "/CN=internal" -addext "subjectAltName = DNS:*.internal" -addext "authorityKeyIdentifier = keyid,issuer" -addext "basicConstraints = CA:false" -newkey rsa:2048 -keyout tls.key -out tls.crt
$ kubectl apply -k

$ curl --cacert cacert.crt https://whoami.internal
curl: (60) SSL: no alternative certificate subject name matches target host name 'whoami.internal'
```
