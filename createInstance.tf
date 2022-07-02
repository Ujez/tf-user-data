resource "aws_key_pair" "levelup_key3" {
  key_name   = "levelup_key3"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Create AWS Instance
resource "aws_instance" "DockerInstance" {
  ami               = lookup(var.AMIS, var.AWS_REGION)
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = aws_key_pair.levelup_key3.key_name

  user_data = file("installapache.sh")

  tags = {
    Name = "userdata_instance"
  }

}

#GET YOUR PUBLIC IP
output "public_ip" {
  value = aws_instance.DockerInstance.public_ip
}
