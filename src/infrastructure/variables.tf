variable "region" {
  type    = string
  default = "us-east-1"

}

variable "config" {
  type    = string
  default = "~/.aws/config"
}

variable "credentials" {
  type    = string
  default = "~/.aws/credentials"
}
