[nodes]
%{ for ip in nodes ~}
${ip}
%{ endfor ~}

[bastion]
${bastion}

[nodes:vars]
ansible_user=ubuntu
become=yes
ansible_ssh_private_key_file=~/.ssh/aws-keypair
drbd_backing_disk=/dev/xvdf
drbd_replication_network=172.17.64.0/18
ansible_ssh_common_args='-o StrictHostKeyChecking=no -o ProxyCommand="ssh -W %h:%p -q ubuntu@${bastion}"'
