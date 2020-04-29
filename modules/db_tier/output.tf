# output pub_ip {
#   description = "this is the id from my security group for the db"
#   value = aws_instance.db_instance.*.public_ip
# }

output "db_private_ip" {
  value = aws_instance.db_instance.private_ip
}
