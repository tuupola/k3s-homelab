```
kubectl exec -it cockroachdb-0 --namespace cockroachdb -- ./cockroach sql --certs-dir=/cockroach/cockroach-certs

CREATE DATABASE ghostfolio;
CREATE USER ghostfolio WITH PASSWORD 'hYxxsizNkQcuqroywU2YiQTFyN3oiWrH';
GRANT admin TO ghostfolio; # THIS IS BAD

GRANT USAGE ON TABLE ghostfolio.* TO ghostfolio;
```
