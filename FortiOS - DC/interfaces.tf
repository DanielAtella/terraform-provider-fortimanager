resource "fortios_networking_interface_port" "vlan1" {
    role = "lan"
    mode = "static"
    type = "vlan"
    vlanid = "3"
    name = "TerraForm-1"
    vdom = "root"
    ip = "3.123.33.10/24"
    interface = "port2"
    allowaccess = "ping"
}