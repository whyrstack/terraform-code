variable "my_vpc_name" {
  description = "VPC name"
  type        = string
  default     = "myVPC"
}

variable "my_vpc_cidr" {
  description = "VPC network cider"
  type        = string
  default     = "10.10.0.0/16"
}

variable "my_vpc_sg_name" {
  description = "Securty Group name applied to VPC"
  type        = string
  default     = "myVPCsg"
}