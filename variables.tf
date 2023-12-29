variable "neighbors" {
  type = map(object({
    customer_asn = string
    address_family = string
    authentication_key = string
  }))
}

variable "vlans" {
  type = list(string)
}

variable "interfaces" {
  type = map(string)
}

variable "hosts" {
  type = list(string)
}

variable "new_deploy" {
  type = bool
  default = true
}

vlanid {
  type = string
}