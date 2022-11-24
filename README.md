# Terraform Example for DRBD in AWS

Deploy a DRBD cluster into Amazon's AWS spanning multiple AZs using Terraform and Ansible.

## Configure variables

Terraform variables such as the AWS keypair, AWS region, LINBIT's Ubuntu AMI for the specified region, and ec2 instance size are specified here.

Unless you've changed the VPC's private subnet variables in the Terraform variables, you won't need to set Ansible variables. If you did, you need to update the subnetmask used for DRBD's replication in the `hosts.tpl` file, which is the Ansible inventory template.

## Determine LINBIT's AMI ID for your region

The default value for LINBIT's Ubuntu AMI ID is for the us-west-2 region. To determine the AMI ID for your region you may use the following command:

```
aws ssm get-parameter \
  --name /aws/service/marketplace/prod-je2obe63gscxa/1.0-2022_11_15 \
  --query "Parameter.Value" --output text \
  --region us-east-1
```

## Deploy infrastructure using Terraform

```
terraform init
terraform plan
terraform apply
```

When the `apply` command completes, it will output the IPs of the bastion
host to SSH through as well as the private IPs of instances inside the VPC.
It will also write out our Ansible host inventory to `./hosts.ini`.


## Configure DRBD cluster using Ansible

You will need to accept the hosts fingerprints before running Ansible. Copy/Paste and accept.

```
for n in $(grep -o 172\.17\.10[0-9]*\.[0-9]* hosts.ini); do
  ansible -i hosts.ini -a hostname $n;
done
```

Then you can run the playbook:

```
ansible-playbook drbd.yaml
```

## Clean up

Destroy the AWS infrastructure deployed with Terraform to cleanup.

```
terraform destroy
```
