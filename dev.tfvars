dev.tfvars:
  region: eu-west-1
  neighbors:
    - { customer_asn: 65536, address_family: ipv4, authentication_key: "mykey" }
  vlans: [100, 200]
  interfaces:
    eth0: "eth0 description"
    eth1: "eth1 description"
  hosts:
    - { ami: ami-0c53b3412a015709f, instance_type: t2.micro }
    - { ami: ami-0c53b3412a015709f, instance_type: t2.micro }