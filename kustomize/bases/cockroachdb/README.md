https://www.cockroachlabs.com/docs/v23.1/deploy-cockroachdb-with-kubernetes?filters=manual

```
$ cockroach cert create-ca \
    --certs-dir=certs \
    --ca-key=safe/ca.key

$ cockroach cert create-client \
    root \
    --certs-dir=certs \
    --ca-key=safe/ca.key

$ kubectl create secret generic cockroachdb.client.root \
    --from-file=certs \
    --namespace cockroachdb

$ cockroach cert create-node \
    localhost 127.0.0.1 \
    cockroachdb-public \
    cockroachdb-public.cockroachdb \
    cockroachdb-public.cockroachdb.svc.cluster.local \
    *.cockroachdb \
    *.cockroachdb.cockroachdb \
    *.cockroachdb.cockroachdb.svc.cluster.local \
    --certs-dir=certs \
    --ca-key=safe/ca.key

$ kubectl create secret generic cockroachdb.node \
    --from-file=certs \
    --namespace cockroachdb

$ kubectl apply -k .

$ kubectl exec -it cockroachdb-0 --namespace cockroachdb -- /cockroach/cockroach init --certs-dir=/cockroach/cockroach-certs

$ kubectl exec -it cockroachdb-0 --namespace cockroachdb -- ./cockroach sql --certs-dir=/cockroach/cockroach-certs

$ kubectl port-forward service/cockroachdb-public 8080 --namespace cockroachdb

CREATE USER foobar WITH PASSWORD 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
GRANT admin TO foobar;
``````