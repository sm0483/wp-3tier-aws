variable "region" {
  type = string
}

variable "config" {
  type    = string
  default = "~/.aws/config"
}

variable "credentials" {
  type    = string
  default = "~/.aws/credentials"
}

variable "my_ip" {
  description = "ip address"
  type        = string
}

variable "zone_one" {
  description = "region"
  type        = string
}

variable "zone_two" {
  description = "region"
  type        = string
}
