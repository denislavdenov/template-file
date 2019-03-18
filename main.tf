resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

data "template_file" "var" {
  template   = "${file("${path.module}/scripts/temp.sh")}"
  depends_on = ["aws_key_pair.key"]

  vars = {
    var1 = "${var.var1}"
    var2 = "${var.var2}"
    var3 = "${var.var3}"
  }
}

resource "aws_instance" "temp1" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.subnet_id}"
  key_name                    = "${aws_key_pair.key.id}"
  vpc_security_group_ids      = "${var.security_group_id}"
  
  connection {
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "cat <<EOT > /var/tmp/temp.sh",
      "${data.template_file.var.rendered}",
      "EOT",
      "sudo bash /var/tmp/temp.sh"
      
    ]
  }
}
output "IP" {
  value = "${aws_instance.temp1.public_ip}"
}
