
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

variable "each_vm" {
  type = list(object({ security_group=string, nat_network_address=string ,vm_name=string, cpu=number, ram=number, disk_volume=number, core_fraction = number, subnet=string, public_network=string }))
  default = [
    {
      vm_name = "public-vm-01",
      cpu = 2,
      ram = 2,
      disk_volume = 15,
      core_fraction = 5
      subnet = "public"
      public_network = true
      nat_network_address = ""
      security_group = "none"
    },
    {
      vm_name = "nat-01",
      cpu = 2,
      ram = 2,
      disk_volume = 15,
      core_fraction = 5
      subnet = "public"
      public_network = false
      nat_network_address = "192.168.10.254"
      security_group = "none"
    },
    {
      vm_name = "private-vm-01",
      cpu = 2,
      ram = 2,
      disk_volume = 15,
      core_fraction = 5
      subnet = "private"
      public_network = false
      nat_network_address = ""
      security_group = "private"
    }
  ]
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
      subnet_name = "private",
      subnet_zone = "ru-central1-a",
      v4_cidr = ["192.168.20.0/24"]
    }
  ]
}
