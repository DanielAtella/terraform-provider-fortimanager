FortiOS - Environment variables

export FORTIOS_ACCESS_HOSTNAME=192.168.216.137
export FORTIOS_ACCESS_TOKEN=7jsrdzt3c3w3q9hjQ9G49pN77mx8Gt

FortiOS and FortiManager Deploy new service

terraform init
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars

FortiOS Destroy service

terraform destroy -var-file=dev.tfvars

FortiManager Destroy service

terraform destroy -var-file=dev.tfvars -var new_deploy="false"


######

Adicionar Resource local

.terraform.d/plugins/project.local/local/{resource_name}/{version}/linux_amd64/{bin}

.terraform.d/plugins/project.local/local/fortimanager/1.10.0/linux_amd64/terraform-provider-fortimanager_v1.9.0



main.tf
terraform {
  required_providers {
    fortimanager = {
      source = "project.local/local/fortimanager"
      version = "1.9.0"
    }
  }
}