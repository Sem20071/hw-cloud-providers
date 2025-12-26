
variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "aleksandrov-vpc"
  description = "VPC network&subnet name"
}

variable "image_name" {
  type        = string 
  default     = "ubuntu-2204-lts-oslogin"
  description = "release name"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"       
  description = "yandex platform"
}

variable "vms_ssh_root_key" {                                                             
  type = string
  default = "ssh = "
  description = "ssh-keygen -t ed25519"
  sensitive   = true
  }

variable "root_user_pass" {                                                             
  type = string
  description = "root user password"
  sensitive   = true
  }

variable "mysql_password" {                                                             
  type = string
  description = "mysql user password"
  sensitive   = true
  }

variable "mysql_user" {                                                             
  type = string
  description = "mysql user name"
  sensitive   = true
  }

variable "each_subnet" {
  type = list(object({  subnet_name=string, subnet_zone=string, v4_cidr = list(string) }))
  default = [
    {
      subnet_name = "public",
      subnet_zone = "ru-central1-a",
      v4_cidr = ["192.168.10.0/24"]
    },
    {
      subnet_name = "public",
      subnet_zone = "ru-central1-b",
      v4_cidr = ["192.168.11.0/24"]
    },
    {
      subnet_name = "public",
      subnet_zone = "ru-central1-d",
      v4_cidr = ["192.168.12.0/24"]
    },
    {
      subnet_name = "private",
      subnet_zone = "ru-central1-a",
      v4_cidr = ["192.168.20.0/24"]
    },
    {
      subnet_name = "private",
      subnet_zone = "ru-central1-b",
      v4_cidr = ["192.168.21.0/24"]
    }
  ]
}
variable "k8s_host_resources" {
  type = object({
    cpu                 = number
    ram                 = number
    disk_volume         = number
    auto_scale_min      = number
    auto_scale_max      = number
    auto_scale_initial  = number
  })
  
  default = {
    cpu                 = 2
    ram                 = 4
    disk_volume         = 60
    auto_scale_min      = 1
    auto_scale_max      = 3
    auto_scale_initial  = 1
  }
}

variable "iam_service_account_name" {                                                             
  type = string
  description = "iam service user name"
  sensitive   = true
  }

variable "iam_k8s_account_name" {                                                             
  type = string
  description = "iam k8s cluster service user name"
  sensitive   = true
  }

variable "db_name" {                                                             
  type = string
  default = "netology_db"
  }

variable "mysql_resources" {
  type = object({
    mysql_cluster_name     = string
    resource_preset        = string
    disk_type              = string
    disk_size              = number
    max_connections        = number

  })
  
  default = {
    mysql_cluster_name     = "cluster-mysql"
    resource_preset        = "b1.medium"
    disk_type              = "network-hdd"
    disk_size              = 20
    max_connections        = 100
  }
}
