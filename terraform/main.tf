provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-053b0d53c279acc90" # Ubuntu 22.04 AMI (us-east-1)
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "WebServer"
  }

  provisioner "local-exec" {
    command = "echo [web] ${self.public_ip} > ../ansible/inventory"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
  }
}

