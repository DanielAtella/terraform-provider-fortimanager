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

Example
mkdir -p /root/.terraform.d/plugins/project.local/local/fortimanager/1.10.0/linux_amd64/

unzip -d /root/.terraform.d/plugins/project.local/local/fortimanager/1.10.0/linux_amd64/ /opt/fmg/terraform-provider-fortimanager_v1.9.0_linux_amd64.zip terraform-provider-fortimanager_v1.9.0

main.tf
terraform {
  required_providers {
    fortimanager = {
      source = "project.local/local/fortimanager"
      version = "1.9.0"
    }
  }
}

####

Permissões FortiOS 

config system accprofile
 edit "API"
        set scope global
        set sysgrp custom
        set netgrp custom
        set fwgrp custom
        set system-diagnostics disable
        config netgrp-permission
            set cfg read-write
        end
        config sysgrp-permission
            set cfg read-write
            set mnt read
        end
        config fwgrp-permission
            set policy read-write
            set address read-write
            set service read-write
        end
    next
end