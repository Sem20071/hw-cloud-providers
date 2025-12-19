
data "yandex_compute_image" "ubuntu" {
  family = var.image_name     
}

resource "yandex_compute_instance" "vms" {            
  for_each    = { for k in var.each_vm : k.vm_name => k }
  name        = each.value.vm_name                                                             
  platform_id = var.vm_platform_id
  hostname    = each.value.vm_name
  resources {
    cores         = each.value.cpu                          
    memory        = each.value.ram                          
    core_fraction = each.value.core_fraction   

  }

  boot_disk {
    initialize_params {

      image_id    = each.value.vm_name == "nat-01" ? "fd80mrhj8fl2oe87o4e1" : data.yandex_compute_image.ubuntu.image_id
      type        = "network-hdd"
      size        = each.value.disk_volume
    }
  }

  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.subnets[each.value.subnet].id
    nat                = each.value.public_network
    ip_address         = each.value.nat_network_address
    security_group_ids = local.security_group_ids[each.value.security_group]

  }
  
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    vms_ssh_root_key = var.vms_ssh_root_key
    root_user_pass = var.root_user_pass
  }
}
