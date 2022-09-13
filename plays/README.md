## pyluks tests: Ansible playbooks
These Ansible playbooks are used to configure the master and worker nodes deployed with Terraform:

* `nfs_playbook.yml` is used to configure NFS to share the volume mountpoint of the master node with the worker node.
* `docker_playbook.yml` is used to configure docker on the master node with the docker images stored in the external volume.
* `pyluks_dev_test.yml` is used to encrypt the storage and set up the luksctl API on the master node.

Install the required ansible roles:
```shell
$ ansible-galaxy install -r requirements.yml
```

### 1. Encrypt volume with pyluks
First, fill the `hosts` inventory file with the master node IP as retrieved from `terraform output`.

A Vault instance properly configured is needed. First, retrieve a Vault token to write the passphrase, then fill the Vault variables in the `pyluks_dev_test.yml` playbook. Finally, run the playbook:
```shell
$ ansible-playbook -i inventory/hosts pyluks_dev_test.yml
```

### 2. Configure Docker
Use the same `hosts` inventory of the previous step.

Then, run the following commands:
```shell
$ ansible-playbook -i inventory/hosts docker_playbook.yml
```

The role will install Docker on the master node and configure it to store the container images in the external volume.

### 3. Configure NFS
First, fill the `hosts_nfs` inventory file with the master and worker node IPs as retrieved from the `terraform output` command.

Then, run the following commands to configure the nodes with Ansible:
```shell
$ export MASTER_IP=$(terraform output -raw master)
$ export WORKER_IP=$(terraform output -raw worker)
$ ansible-playbook -i inventory/hosts_nfs -e nfs_server_ip=${MASTER_IP} -e nfs_client_ip=${WORKER_IP} nfs_playbook.yml
```

The role will configure NFS to share the /export directory of the master node (where the external volume is mounted) on the worker node in /export.
