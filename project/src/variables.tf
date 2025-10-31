###cloud vars

variable "cloud_id" {
  type        = string
  default     = "b1gir8riec888u13t2l6"
}

variable "folder_id" {
  type        = string
  default     = "b1gtcvs9o26k594vhho4"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-d"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vpc_name" {
  type        = string
  default     = "project"
  description = "VPC network&subnet name"
}

variable "vm_platform" {
  type        = string
  default     = "standard-v3"
  description = "Platform-id Intel Ice Lake"
}

variable "vm_cpu_core" {
  type        = number
  default     = 2
  description = "Number of cores cpu"
}

variable "vm_cpu_fraction" {
  type        = number
  default     = 20
  description = "Core fraction % CPU"
}

variable "vm_ram" {
  type        = number
  default     = 2
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
  type = map(string)
  default = {
    serial-port-enable = "1"
  }
  description = "Metadata for all VMs"
}

variable "lockbox_secret_id" {
  type    = string
  default = "e6qdi3pd8l0aniaj36r2"
}

variable "sa_id" {
  type        = string
  default     = "ajevbhorm05mmmn882e2"
  description = "Service account ID for VM to access Container Registry"
}

variable "project_name" {
  type        = string
  default     = "neto-ter-project"
  description = "Project name for resource naming"
}

variable "mysql_environment" {
  type        = string
  default     = "PRODUCTION"
}

variable "mysql_version" {
  type        = string
  default     = "8.4"
}

variable "mysql_disk_type" {
  type        = string
  default     = "network-hdd"
}

variable "mysql_resource_preset_id" {
  type        = string
  default     = "b2.medium"
}

variable "mysql_disk_size" {
  type        = number
  default     = 10
}