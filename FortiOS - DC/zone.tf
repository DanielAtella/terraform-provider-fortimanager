resource "fortios_system_zone" "Zone_100_PSA" {
  intrazone = "allow"
  name      = var.DC.PSA.zone
  interface {
    interface_name = var.DC.PSA.dmz0_ifname
  }
  interface {
    interface_name = "port2"
  }
}