resource "aws_instance" "main" {
  
  key_name                = var.my_key
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.medium"
  #user_data               = "${file("install-script.sh")}"
  associate_public_ip_address = true
  count = 1

  tags = {
    name = "My-EC2-${count.index}"
  }
}