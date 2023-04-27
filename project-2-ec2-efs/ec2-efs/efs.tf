#
#
resource "aws_efs_file_system" "my_efs" {
   creation_token = "efs-token-name"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
#  kms_key_id = data.aws_kms_key.by_alias.id
 tags = {
     Name = "Share-1"
   }
 }

 resource "aws_efs_mount_target" "my_efs_mount" {
   file_system_id  = "${aws_efs_file_system.my_efs.id}"
   subnet_id = data.aws_subnets.subnets_public.id
   security_groups = data.aws_security_groups.selected.ids
 }