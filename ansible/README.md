# Install required software with Ansible

Install required software by running Ansible playbook. Instructions require the hostnames matching your inventory such as `nuc-00.internal` will resolve. Add them to either to dns or your `/etc/hosts` file.

```
$ ansible -v playbook.yaml
```

You can also run each step manually as described below.

## Initial user for Ansible

You must be able to remotely login with either `root` or `ansible` user. If using `root` the `ansible` user will be created.

```
$ ssh-copy-id -i ~/.ssh/ansible_ed25519.pub root@nuc-00.internal
$ ssh-copy-id -i ~/.ssh/ansible_ed25519.pub root@nuc-01.internal
$ ssh-copy-id -i ~/.ssh/ansible_ed25519.pub root@nuc-02.internal
$ ssh-copy-id -i ~/.ssh/ansible_ed25519.pub root@storage-00.internal
$ ansible-playbook -v users.yaml
```

## Add entries to hosts file

Add entries from inventory to the `/etc/hosts` file in each NUC.

```
$ ansible-playbook -v hosts.yaml
```

## Configure firewall

This currently just disables firewalld.

```
$ ansible-playbook -v firewall.yaml
```

## Resize root disk

```
$ ansible-playbook -v resize-root.yaml
```

Could also be done manually.

```
$ df -h /
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/fedora-root   15G   13G  2.7G  83% /

$ sudo lvdisplay
  --- Logical volume ---
  LV Path                /dev/fedora/root
  LV Name                root
  VG Name                fedora
...

$ sudo lvresize --size 32G --resizefs /dev/fedora/root
  Size of logical volume fedora/root changed from 16.00 GiB (4096 extents) to 32.00 GiB (8192 extents).

$ df -h /
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/fedora-root   32G   13G   20G  39% /
```

## Upgrade all DNF packages to latest

```
$ ansible-playbook -v upgrade.yaml
```

## Install K3S

This installs a multinode cluster.

```
$ ansible-playbook -v cluster.yaml
```

After installing copy the kubectl config file to your local machine and point it to correct host.

```
$ scp ansible@nuc-00.internal:/etc/rancher/k3s/k3s.yaml .
$ sed -i 's/127.0.0.1/nuc-00/g' k3s.yaml
$ export KUBECONFIG=/path/to/home-lab/k3s.yaml
```

```
$ kubectl get nodes
NAME         STATUS   ROLES                       AGE     VERSION
nuc-00       Ready    control-plane,etcd,master   7h45m   v1.27.16+k3s1
nuc-01       Ready    control-plane,etcd,master   7h38m   v1.27.16+k3s1
nuc-02       Ready    control-plane,etcd,master   7h44m   v1.27.16+k3s1
storage-00   Ready    <none>                      5m4s    v1.27.16+k3s1

```

# Longhorn prerequisites

```
$ ansible-playbook -v longhorn.yaml
```

Now you can start installing stuff from kustomize folder.
