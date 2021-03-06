# Ansible Playbooks and Terraform configuration files
## Ansible - playbooks

`nginx.yaml` - installs nginx on a remote server and copies files from client to server  
`ec2_launch.yml` - launches an EC2 install, install nginx on it and transfer files to be served as a static site  
`prometheus_blackbox.yml` - sets up the Prometheus blackbox exporter on an EC2 instance  
  
`haproxy_nginx` - installs nginx on 2 servers and haproxy on another one (with roles)  
`prometheus_grafana` - installs Prometheus and Grafana on a server 

## Terraform configuration files

`main.tf` and `variables.tf` to provision 3 instances on GCP with Terraform.