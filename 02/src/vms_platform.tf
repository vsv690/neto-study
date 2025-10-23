# Переменные для ВМ № 1 "vm_web"

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name for instance vm_web"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v2"
  description = "Platform-id Intel Cascade Lake"
}

variable "vm_web_cpu_core" {
  type        = number
  default     = 2
  description = "Number of cores cpu"
}

variable "vm_web_ram" {
  type        = number
  default     = 1
  description = "RAM capacity GB"
}

variable "vm_web_cpu_fraction" {
  type        = number
  default     = 5
  description = "Core fraction % CPU"
}


# Переменные для ВМ № 2 "vm_db"

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name for instance vm_db"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v2"
  description = "Platform-id Intel Cascade Lake"
}

variable "vm_db_cpu_core" {
  type        = number
  default     = 2
  description = "Number of cores cpu"
}

variable "vm_db_ram" {
  type        = number
  default     = 2
  description = "RAM capacity GB"
}

variable "vm_db_cpu_fraction" {
  type        = number
  default     = 20
  description = "Core fraction % CPU"
}