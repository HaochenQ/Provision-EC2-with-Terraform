//use the default security group (come out of the box with the creation of our vpc)
resource "aws_security_group" "myapp-sg" {
  vpc_id = var.vpc_id
  ingress {
    description = "value"
    //port range
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] //var.my_ip
  }

  ingress {
    description = "value"
    //port range
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.env_prefix}-default-sg"
  }
}

//fetch ami of amazon linux image

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = [var.image_name]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



resource "aws_key_pair" "ssh-key" {
  key_name   = "server-key"
  public_key = file(var.public_key_location) //var.my_public_key 
}

//provision ec2 instances
resource "aws_instance" "myapp-server" {
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  //make the instance to be created inside our vpc and subnet
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone      = var.avail_zone

  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name //"server_key_pair"

  //entry point to configure your instance
  user_data_replace_on_change = true
  user_data                   = file("./entry-script.sh")
  #   user_data                   = <<EOF
  #   #!/bin/bash
  #   sudo yum update -y && sudo yum install -y docker
  #   sudo systemctl start docker
  #   sudo usermod -aG docker ec2-user
  #   sudo docker run -p 8080:80 nginx

  #   EOF

  //provisioner
  #   connection {
  #     type        = "ssh"
  #     host        = self.public_ip
  #     user        = "ec2-user"
  #     private_key = file(var.private_key_location)
  #   }

  //copy file to the remote instance
  #   provisioner "file" {
  #     source      = "entry-script.sh"
  #     destination = "/home/user-ec2/entry-script-on-ec2.sh"
  #   }
  // execute comands on the remotes instance
  #   provisioner "remote-exec" {
  #     # inline = [
  #     #   "export ENV=dev",
  #     #   "mkdir newdir"
  #     # ]

  #     script = file("/home/user-ec2/entry-script-on-ec2.sh")
  #   }

  //file("./entry-script.sh")

  //local provisioner
  #   provisioner "local-exec" {
  #     command = "echo ${self.public_ip} > output.txt"
  #   }


  tags = {
    Name = "${var.env_prefix}-server"
  }
}




