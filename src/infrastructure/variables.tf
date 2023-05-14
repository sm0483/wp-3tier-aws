variable "region" {
  type    = string
  default = "ap-south-1"

}

variable "config" {
  type    = string
  default = "~/.aws/config"
}

variable "credentials" {
  type    = string
  default = "~/.aws/credentials"
}
