# Install required software with Ansible

Install required software by running Ansible playbook. Instructions require the hostnames matching your inventory such as `nuc-00.internal` will resolve. Add them to your `/etc/hosts`.

```
$ ansible -v playbook.yaml
```

You can also run each step manually as described below.

## Initial user for Ansible

You must be able to remotely login with either `root` or `ansible` user. If using `root` the `ansible` user will be created.

```
$ ssh-copy-id -i ~/.ssh/ansible_ed25519.pub root@nuc-00.internal
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

## Install K3S

You can either install a single node or a multinode cluster.

```
$ ansible-playbook -v single.yaml
```
```
$ ansible-playbook -v multi.yaml
```

After installing copy the kubectl config file to your local machine and point it to correct host.

```
$ scp ansible@nuc-00.internal:/etc/rancher/k3s/k3s.yaml
$ sed -i 's/127.0.0.1/nuc-00.internal/g' k3s.yaml
```
