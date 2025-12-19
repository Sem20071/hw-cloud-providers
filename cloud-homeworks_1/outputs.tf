output "vm_instances" {
  description = "Все ВМ созданы"
  value = {
    for name, instance in yandex_compute_instance.vms : name => {
      "name"       = instance.name
      "public_ip"  = instance.network_interface[0].nat_ip_address
    }
  }
}