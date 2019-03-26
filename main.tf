# This code assume you have your own ssh key, and you want to use that to connect to the new ami
resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

# This code is used to provide terraform script with variables.
data "template_file" "var" {
  template   = "${file("${path.module}/scripts/temp.tpl")}"
  depends_on = ["aws_key_pair.key"]

  vars = {
    var1 = "${var.var1}"
    var2 = "${var.var2}"
    var3 = "${var.var3}"
  }
}

# Code below creates an AMI and provisions it with the script created using the template-file data source
resource "aws_instance" "temp1" {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${aws_key_pair.key.id}"
  vpc_security_group_ids = "${var.security_group_id}"

  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    content     = "${data.template_file.var.rendered}"
    destination = "/var/tmp/temp.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /var/tmp/temp.sh",
    ]
  }
}

output "IP" {
  value = "${aws_instance.temp1.public_ip}"
}
