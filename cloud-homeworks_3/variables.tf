variable "service_account" {
  type        = string
  description = ""
}

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
  type        = string
  default     = "ssh = "
  description = "ssh-keygen -t ed25519"
  sensitive   = true
  }

variable "root_user_pass" {                                                             
  type = string
  description = "root user password"
  sensitive   = true
  }

# variable "vm_resource" {
#   type = object({
#     security_group      = string
#     nat_network_address = string
#     vm_name             = string
#     cpu                 = number
#     ram                 = number
#     disk_volume         = number
#     core_fraction       = number
#     subnet              = string
#     public_network      = bool
#     vm_image_id         = string
#   })
  
#   default = {
#     security_group      = "none"
#     nat_network_address = ""
#     vm_name             = "public-vm-01"
#     cpu                 = 2
#     ram                 = 2
#     disk_volume         = 15
#     core_fraction       = 20
#     subnet              = "public"
#     public_network      = false
#     vm_image_id         = "fd827b91d99psvq5fjit"
#   }
# }

variable "each_subnet" {
  type = list(object({  subnet_name=string, subnet_zone=string, v4_cidr = list(string) }))
  default = [
    {
      subnet_name = "public",
      subnet_zone = "ru-central1-a",
      v4_cidr     = ["192.168.10.0/24"]
    },
    {
      subnet_name = "private",
      subnet_zone = "ru-central1-a",
      v4_cidr     = ["192.168.20.0/24"]
    }
  ]
}

variable "bucket_name" {
  type        = string
  default     = "aleksandrov"
  description = "s3 bucket name"
}

# variable "hc_config" {
#   type = object({
#     hc_interval             = number
#     hc_timeout              = number
#     hc_unhealthy_threshold  = number
#     hc_healthy_threshold    = number
#     hc_port                 = number
#     hc_path                 = string
#   })
  
#   default = {
#     hc_interval             = 10
#     hc_timeout              = 5
#     hc_unhealthy_threshold  = 5
#     hc_healthy_threshold    = 5
#     hc_port                 = 80
#     hc_path                 = "/"
#   }
# }
