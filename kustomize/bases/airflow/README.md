
```
$ kubectl apply -k .
$ kubectl exec -it cockroachdb-0 --namespace cockroachdb -- ./cockroach sql --certs-dir=/cockroach/cockroach-certs

CREATE DATABASE airflow;
CREATE USER airflow WITH PASSWORD 'supersiikret';
GRANT admin TO airflow;


$ airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.org
```