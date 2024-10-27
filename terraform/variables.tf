variable "ami" {
  type        = string
  description = "Amazon Linux 2"
  default     = "ami-0ddc798b3f1a5117e"
}
variable "key_name" {
  type        = string
  description = "Key Pair name"
  default     = "devops"
}
variable "vpc_id" {
  type        = string
  description = "Default VPC ID"
}
variable "subnet_uk" {
  type        = string
  description = "Subnet ID in AZ targeted for UK"
}
variable "subnet_global" {
  type        = string
  description = "Subnet ID in AZ targeted for Global"
}
variable "vpc_sg" {
  type        = string
  description = "Default Security Group"
}