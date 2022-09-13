## terraform-pyluks-test
Terraform recipe to deploy a master and worker node to test [pyluks](https://github.com/Laniakea-elixir-it/pyluks) over OpenStack. The master node has an attached volume which can then be encrypted with the [laniakea.luks_encryption](https://github.com/Laniakea-elixir-it/ansible-role-luks-encryption) Ansible role.

The deployed VMs can be configured to test the pyluks package with the Ansible playbooks in the `plays` directory.

### Dependencies
- Terraform v1.1.2
- Openstack tenant with floating ips
- Ansible 2.9.26

### How to deploy
1. Fill the `variables.tf`  
2. Source the openstack rc file
3. Run `terraform apply` to create the infrastructure
4. Run `terraform destroy` to delete the infrastructure after tests

### How to run Ansible playbooks
1. Run `terraform output` to retrieve the master and worker IPs
2. Follow the indications in the `plays` README
