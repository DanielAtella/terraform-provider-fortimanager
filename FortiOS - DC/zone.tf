resource "fortios_system_zone" "trname" {
  intrazone = "allow"
  name      = "DMZ"
  interface {
    interface_name = "TerraForm-1"
  }
}
