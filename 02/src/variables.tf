###cloud vars

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

variable "default_zone_d" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_zone_b" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr_b" {
  type        = list(string)
  default     = ["10.10.10.0/28"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_d" {
  type        = list(string)
  default     = ["10.10.10.16/28"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_network_name" {
  type        = string
  default     = "network_develop"
  description = "name subnet b"
}

variable "vpc_subnet_name_b" {
  type        = string
  default     = "sub_dev_b"
  description = "name subnet b"
}

variable "vpc_subnet_name_d" {
  type        = string
  default     = "sub_dev_d"
  description = "name subnet d"
}

variable "vm_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Family image Ubuntu 20.04 LTS"
}

/* Переменная заменена двумя переменными ниже, которые объединяются в локальной переменной metadata_full
variable "vms_ssh_root_key" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "Keys from MBPM4P"
}
*/

variable "metadata" {
  type        = map(string)
  default     = {
    serial-port-enable = "1"
  }
  description = "Metadata for all Ubuntu VMs"
}

variable "vms_ssh_root_key" {
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
  description = "Path to SSH public key"
}

variable "vms_resources" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
  }))
  default = {
    web = {
      cores = 2
      memory = 1
      core_fraction = 5      
    }
    db = {
      cores = 2
      memory = 2
      core_fraction = 20
    }
  }
}