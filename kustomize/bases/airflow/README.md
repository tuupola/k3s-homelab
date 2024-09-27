
```
$ kubectl apply -k .

$ kubectl exec -it -n airflow postgres-0 -- bash
$ psql

$ kubectl exec -it -n airflow deployment.apps/airflow -- bash
$ airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.org
```

```
 kubectl --namespace airflow port-forward service/airflow 8080:8080
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

After config change

```
kubectl rollout restart -n airflow deployment.apps/airflow
```

docker build . -f Dockerfile --pull --tag tuupola/airflow-crdb:2.7.1-202310041420
docker build . --pull --tag tuupola/airflow-crdb:2.7.1-202310041420

date +"%Y%m%d%H%M"
