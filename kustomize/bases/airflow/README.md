
```
$ kubectl apply -k .
$ kubectl exec -it cockroachdb-0 --namespace cockroachdb -- ./cockroach sql --certs-dir=/cockroach/cockroach-certs

CREATE DATABASE airflow;
CREATE USER airflow WITH PASSWORD 'supersiikret';
GRANT admin TO airflow;

$ kubectl exec -it -n airflow deployment.apps/airflow -- bash
$ airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.org
```

Cannot add dags via configMapGenerator because:

```
RuntimeError: Detected recursive loop when walking DAG directory /opt/airflow/dags: /opt/airflow/dags/..2023_09_26_11_24_35.1086950748 has appeared more than once.
```

So copy files instead, for now...

```
kubectl cp <some-namespace>/<some-pod>:/tmp/foo /tmp/bar
kubectl cp opt/airflow/dags/hello.py airflow/airflow-webserver-7847597cb9-898rm:/opt/airflow/dags/hello.py
```