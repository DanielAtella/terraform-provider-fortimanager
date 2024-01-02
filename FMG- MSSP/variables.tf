variable "customer" {
  type = map(object({
    customer_asn = string
    address_family = string
    authentication_key = string
    vlanid = number
    adom = string
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