variable "aws_access_key" {
  description = "Your AWS access key"
}

variable "aws_secret_key" {
  description = "Your AWS secret key"
}

variable "instance_type" {
  description = "Specify the preferred instance type"
}

variable "subnet_id" {
  description = "Specify the preferred subnet"
}

variable "region" {
  description = "Specify the prefered AWS region"
}

variable "security_group_id" {
  type = "list"
  description = "Specify the prefered AWS security group"
}

variable "ami" {
  description = "Specify the prefered AWS AMI id"
}

variable "var1" {
  description = "String that will be interpolated inside a script that template-file creates"
}
variable "var2" {
  description = "String that will be interpolated inside a script that template-file creates"
}
variable "var3" {
  description = "String that will be interpolated inside a script that template-file creates"
}
