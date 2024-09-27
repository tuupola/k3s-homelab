
```
$ kubectl label nodes nuc-00 "intel.feature.node.kubernetes.io/gpu=true"
$ kubectl label nodes nuc-01 "intel.feature.node.kubernetes.io/gpu=true"
$ kubectl label nodes nuc-02 "intel.feature.node.kubernetes.io/gpu=true"
$ kubectl apply -k .
```

```
$ kubectl get nodes -o=jsonpath="{range .items[*]}{.metadata.name}{'\n'}{' i915: '}{.status.allocatable.gpu\.intel\.com/i915}{'\n'}"
nuc-00
 i915: 1
nuc-01
 i915: 1
nuc-02
 i915: 1
storage-00
 i915: 
```
