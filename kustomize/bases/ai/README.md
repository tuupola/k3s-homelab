```
$ cp config.env.dist config.env
$ vi config.env
$ kubectl apply -k .
```

```$ curl --include --insecure https://ollama.internal/
HTTP/2 200
content-type: text/plain; charset=utf-8
date: Sun, 05 May 2024 08:19:17 GMT
content-length: 17

Ollama is running
```
