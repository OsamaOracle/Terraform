# Define SSH key pair for the instances
resource "aws_key_pair" "default" {
  key_name = "terraform_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAtGCFXHeo9igKRzm3hNG5WZKXkQ3/NqQc1WPN8pSrEb0ZjW8mTKXRWzePuVYXYP9txqEKQmJJ1bk+pYX/zDdhJg/yZbZGH4V0LvDY5X5ndnAjN6CHkS6iK2EK1GlyJs6fsa+6oUeH23W2w49GHivSsCZUZuaSwdORoJk9QLeJ7Qz+9YQWOk0efOr+eIykxIDwR71SX5X65USbR8JbuT2kyrp1kVKsmPMcfy2Ehzd4VjShlHsZZlbzKTyfgaX/JJmYXO5yD4VLSjY8BVil4Yq/R9Tkz9pFxCG230XdFWCFEHSqS7TIDFbhPkp18jna6P6hlfNb9WM2gVZbYvr1MMnAVQ== rsa-key-20190805"
}

# Define a server 1 inside the public subnet
resource "aws_instance" "public_server" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.public-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgpub.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("userdata.sh")}"

  tags = {
    Name = "public_server"
  }
}

# Define database inside the private subnet
resource "aws_instance" "private_server1" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.private-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgpriv.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("userdata.sh")}"

  tags = {
    Name = "private_server1"
  }
}

# Define database inside the private subnet
resource "aws_instance" "private_server2" {
   ami  = "${var.ami}"
   instance_type = "t1.micro"
   key_name = "${aws_key_pair.default.id}"
   subnet_id = "${aws_subnet.private-subnet.id}"
   vpc_security_group_ids = ["${aws_security_group.sgpriv.id}"]
   associate_public_ip_address = true
   source_dest_check = false
   user_data = "${file("userdata.sh")}"

  tags = {
    Name = "private_server2"
  }
}



