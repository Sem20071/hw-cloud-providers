
# data "yandex_compute_image" "ubuntu" {
#   family = var.image_name     
# }

# resource "yandex_compute_instance_group" "my-instance-group" {
#   name               = "my-instance-group"
#   folder_id          = var.folder_id
#   service_account_id = var.service_account
  
#   instance_template {
#     platform_id = "standard-v1"
    
#     resources {
#       memory        = var.vm_resource.ram
#       cores         = var.vm_resource.cpu
#       core_fraction = var.vm_resource.core_fraction
#     }

#     boot_disk {
#       mode = "READ_WRITE"
#       initialize_params {
#         image_id = var.vm_resource.vm_image_id
#         size     = var.vm_resource.disk_volume
#       }
#     }

#     network_interface {
#       network_id = yandex_vpc_network.aleksandrov-vpc.id
#       subnet_ids = [yandex_vpc_subnet.subnets[var.vm_resource.subnet].id]
#       nat        = var.vm_resource.public_network
#     }

#     metadata = {
#       user-data          = data.template_file.cloudinit.rendered
#       serial-port-enable = 1
#     }

#     scheduling_policy {
#       preemptible = false
#     }
#   }

#   scale_policy {
#     fixed_scale {
#       size = 3
#     }
#   }

#   allocation_policy {
#     zones = ["ru-central1-a"]
#   }

#   deploy_policy {
#     max_unavailable = 1
#     max_expansion   = 0
#   }

#   # Health checks
#   health_check {
#     interval            = var.hc_config.hc_interval
#     timeout             = var.hc_config.hc_timeout
#     unhealthy_threshold = var.hc_config.hc_unhealthy_threshold
#     healthy_threshold   = var.hc_config.hc_healthy_threshold

#     http_options {
#       port = var.hc_config.hc_port
#       path = var.hc_config.hc_path
#     }
#   }

#   load_balancer {
#     target_group_name = "lamp-target-group"
#   }
# }

# resource "yandex_lb_network_load_balancer" "lamp-nlb-1" {
#   name = "lamp-nlb-1"

#   listener {
#     name = "lamp-nlb-1-listener"
#     port = 80
#     external_address_spec {
#       ip_version = "ipv4"
#     }
#   }

#   attached_target_group {
#     target_group_id = yandex_compute_instance_group.my-instance-group.load_balancer.0.target_group_id

#     healthcheck {
#       name = "http"
#       http_options {
#         port = 80
#         path = "/"
#       }
#     }
#   }
# }

# data "template_file" "cloudinit" {
#   template = file("./cloud-init.yml")
#   vars = {
#     vms_ssh_root_key = var.vms_ssh_root_key
#     root_user_pass   = var.root_user_pass
#     image_url        = local.image_public_url
#   }
# }
