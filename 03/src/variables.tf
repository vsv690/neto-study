###cloud vars

/*
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "vm_name" {
  type        = string
  default     = "netology-develop"
  description = "Default name for instance"
}

*/

variable "cloud_id" {
  type        = string
  default     = "b1gir8riec888u13t2l6"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1gtcvs9o26k594vhho4"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_platform" {
  type        = string
  default     = "standard-v2"
  description = "Platform-id Intel Cascade Lake"
}

variable "vm_cpu_core" {
  type        = number
  default     = 2
  description = "Number of cores cpu"
}

variable "vm_cpu_fraction" {
  type        = number
  default     = 5
  description = "Core fraction % CPU"
}

variable "vm_ram" {
  type        = number
  default     = 1
  description = "RAM capacity GB"
}

variable "vm_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Family image Ubuntu 20.04 LTS"
}

variable "vms_ssh_root_key" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "Path to SSH public key"
}

variable "metadata" {
  type        = map(string)
  default     = {
    serial-port-enable = "1"
  }
  description = "Metadata for all Ubuntu VMs"
}

variable "each_vm" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
}