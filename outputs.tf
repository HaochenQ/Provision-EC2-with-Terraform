# output "aws-ami-id" {
#   value = data.aws_ami.latest-amazon-linux-image.id
# }

output "ec2-pubic-ip" {
  value = module.myapp-server.intance.public_ip
}
