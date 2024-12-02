```
$ cp config.env.dist config.env
$ vi config.env
$ kubectl apply -k .
```

```
$ kubectl get -k .
NAME                TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)     AGE
service/ollama      ClusterIP   10.43.115.115   <none>        11434/TCP   24h
service/openwebui   ClusterIP   10.43.135.101   <none>        8080/TCP    88m

NAME                         READY   AGE
statefulset.apps/ollama      1/1     24h
statefulset.apps/openwebui   1/1     88m

NAME                                  CLASS     HOSTS                ADDRESS          PORTS   AGE
ingress.networking.k8s.io/ollama      traefik   ollama.internal      192.168.20.200   80      24h
ingress.networking.k8s.io/openwebui   traefik   openwebui.internal   192.168.20.200   80
```

```
$ curl --include --insecure https://ollama.internal/
HTTP/2 200
content-type: text/plain; charset=utf-8
date: Sun, 05 May 2024 08:19:17 GMT
content-length: 17

Ollama is running
```

```
$ curl --include --insecure https://openwebui.internal/
HTTP/2 200
content-type: text/plain; charset=utf-8
date: Sun, 05 May 2024 08:19:17 GMT
content-length: 17

HTTP/2 200
content-type: text/html; charset=utf-8
date: Mon, 06 May 2024 09:14:10 GMT
etag: "6bedc15ec1f81a09e260af5b660305e8"
last-modified: Fri, 03 May 2024 07:18:32 GMT
server: uvicorn
x-process-time: 0
content-length: 3496

<!DOCTYPE html>
...
```
