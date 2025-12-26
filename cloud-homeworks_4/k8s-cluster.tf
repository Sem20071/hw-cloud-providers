resource "yandex_iam_service_account" "k8s-sa" {
  name        = var.iam_k8s_account_name
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-roles" {
  for_each = toset([
    "editor",
    "container-registry.images.puller",
    "kms.keys.encrypterDecrypter",
    "load-balancer.admin",
    "vpc.publicAdmin",
    "certificate-manager.certificates.downloader"
  ])
  
  folder_id = var.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.k8s-sa.id}"
}

resource "yandex_iam_service_account" "node-sa" {
  name        = var.iam_service_account_name
}

resource "yandex_resourcemanager_folder_iam_member" "node-roles" {
  for_each = toset([
    "container-registry.images.puller",
    "monitoring.viewer",
    "logging.writer",
    "kms.keys.encrypterDecrypter"
  ])
  
  folder_id = var.folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.node-sa.id}"
}

resource "yandex_kms_symmetric_key" "k8s-key" {
  name              = "k8s-encryption-key"
  default_algorithm = "AES_256"
  rotation_period   = "4320h"
}

resource "yandex_kms_symmetric_key_iam_binding" "viewer" {
  symmetric_key_id = yandex_kms_symmetric_key.k8s-key.id
  role             = "viewer"
  
  members = [
    "serviceAccount:${yandex_iam_service_account.k8s-sa.id}",
    "serviceAccount:${yandex_iam_service_account.node-sa.id}"
  ]
}

resource "yandex_kubernetes_cluster" "netology-k8s" {
  name        = "netology-k8s-cluster"
  network_id  = yandex_vpc_network.aleksandrov-vpc.id

  master {
    regional {
      region = "ru-central1"
      
      location {
        zone      = "ru-central1-a"
        subnet_id = yandex_vpc_subnet.subnets["public-ru-central1-a"].id
      }
      
      location {
        zone      = "ru-central1-b"
        subnet_id = yandex_vpc_subnet.subnets["public-ru-central1-b"].id
      }
      
      location {
        zone      = "ru-central1-d"
        subnet_id = yandex_vpc_subnet.subnets["public-ru-central1-d"].id
      }
    }
    
    version   = "1.34"
    public_ip = true
    

    maintenance_policy {
      auto_upgrade = true
      
      maintenance_window {
        day        = "sunday"
        start_time = "03:00"
        duration   = "3h"
      }
    }
  }
  
  kms_provider {
    key_id = yandex_kms_symmetric_key.k8s-key.id
  }

  service_account_id      = yandex_iam_service_account.k8s-sa.id
  node_service_account_id = yandex_iam_service_account.node-sa.id
  
  cluster_ipv4_range = "10.112.0.0/16"
  service_ipv4_range = "10.96.0.0/16"
  
  release_channel = "RAPID"  # или REGULAR
  
  network_policy_provider = "CALICO"
  
  depends_on = [
    yandex_vpc_network.aleksandrov-vpc,
    yandex_vpc_subnet.subnets,
    yandex_resourcemanager_folder_iam_member.k8s-roles,
    yandex_resourcemanager_folder_iam_member.node-roles
  ]
}

resource "yandex_kubernetes_node_group" "k8s-node-group-a" {
  cluster_id  = yandex_kubernetes_cluster.netology-k8s.id
  name        = "netology-node-group-a"
  
  version = "1.34"
  
  instance_template {
    platform_id = "standard-v3"
    
    resources {
      memory = var.k8s_host_resources.ram
      cores  = var.k8s_host_resources.cpu
    }
    
    boot_disk {
      type = "network-hdd"
      size = var.k8s_host_resources.disk_volume
    }
    
    scheduling_policy {
      preemptible = false
    }
    
    network_interface {
      subnet_ids = [yandex_vpc_subnet.subnets["public-ru-central1-a"].id]
      ipv4       = true
      nat        = true
    }
    
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    
    container_runtime {
      type = "containerd"
    }
  }
  
  scale_policy {
    auto_scale {
      min     = var.k8s_host_resources.auto_scale_min
      max     = var.k8s_host_resources.auto_scale_max
      initial = var.k8s_host_resources.auto_scale_initial
    }
  }
  
  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }
  
  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
    
    maintenance_window {
      day        = "saturday"
      start_time = "02:00"
      duration   = "4h"
    }
  }
  
  node_labels = {
    "environment" = "production"
    "app"         = "netology"
    "zone"        = "ru-central1-a"
  }
}

resource "yandex_kubernetes_node_group" "k8s-node-group-b" {
  cluster_id  = yandex_kubernetes_cluster.netology-k8s.id
  name        = "netology-node-group-b"
  
  version = "1.34"
  
  instance_template {
    platform_id = "standard-v3"
    
    resources {
      memory = var.k8s_host_resources.ram
      cores  = var.k8s_host_resources.cpu
    }
    
    boot_disk {
      type = "network-hdd"
      size = var.k8s_host_resources.disk_volume
    }
    
    scheduling_policy {
      preemptible = false
    }
    
    network_interface {
      subnet_ids = [yandex_vpc_subnet.subnets["public-ru-central1-b"].id]
      ipv4       = true
      nat        = true
    }
    
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    
    container_runtime {
      type = "containerd"
    }
  }
  
  scale_policy {
    auto_scale {
      min     = var.k8s_host_resources.auto_scale_min
      max     = var.k8s_host_resources.auto_scale_max
      initial = var.k8s_host_resources.auto_scale_initial
    }
  }
  
  allocation_policy {
    location {
      zone = "ru-central1-b"
    }
  }
  
  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
    
    maintenance_window {
      day        = "saturday"
      start_time = "02:00"
      duration   = "4h"
    }
  }
  
  node_labels = {
    "environment" = "production"
    "app"         = "netology"
    "zone"        = "ru-central1-b"
  }
}

resource "yandex_kubernetes_node_group" "k8s-node-group-d" {
  cluster_id  = yandex_kubernetes_cluster.netology-k8s.id
  name        = "netology-node-group-d"
  
  version = "1.34"
  
  instance_template {
    platform_id = "standard-v3"
    
    resources {
      memory = var.k8s_host_resources.ram
      cores  = var.k8s_host_resources.cpu
    }
    
    boot_disk {
      type = "network-hdd"
      size = var.k8s_host_resources.disk_volume
    }
    
    scheduling_policy {
      preemptible = false
    }
    
    network_interface {
      subnet_ids = [yandex_vpc_subnet.subnets["public-ru-central1-d"].id]
      ipv4       = true
      nat        = true
    }
    
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    
    container_runtime {
      type = "containerd"
    }
  }
  
  scale_policy {
    auto_scale {
      min     = var.k8s_host_resources.auto_scale_min
      max     = var.k8s_host_resources.auto_scale_max
      initial = var.k8s_host_resources.auto_scale_initial
    }
  }
  
  allocation_policy {
    location {
      zone = "ru-central1-d"
    }
  }
  
  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true
    
    maintenance_window {
      day        = "saturday"
      start_time = "02:00"
      duration   = "4h"
    }
  }
  
  node_labels = {
    "environment" = "production"
    "app"         = "netology"
    "zone"        = "ru-central1-d"
  }
}
