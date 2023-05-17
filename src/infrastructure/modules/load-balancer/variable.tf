variable "subnet_ids" {
  type = object({
    public_1  = string
    public_2  = string
    private_1 = string
    private_2 = string
    private_3 = string
    private_4 = string
  })
}

variable "lb_sg_id" {
  type = string
}


variable "ec2_ids" {
  type = object({
    node_1_public  = string
    node_1_private = string
    node_2_private = string
  })
}

variable "vpc_id" {
  type = string
}
