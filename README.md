# Example how to use template file in Terraform

Fork and clone the repo.

Create a `terraform.tfvars` file and fill in a value for all the variables in `variables.tf` file.

When done, do `terraform plan` and then `terraform apply`.

In `/var/tmp/` on the server that is created should be text file `temp.txt` with a string `Hello content of var1 content of var2 content of var3!`

