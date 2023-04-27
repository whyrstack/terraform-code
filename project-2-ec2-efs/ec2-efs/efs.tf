resource "aws_efs_file_system" "my_efs" {
   creation_token = "efs-token"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
   availability_zone_name = "${data.aws_availability_zones.available.names[0]}"
 tags = {
     Name = "EFS-Share-1"
   }
 }

resource "aws_efs_mount_target" "my_efs_mount" {
   file_system_id  = "${aws_efs_file_system.my_efs.id}"
   subnet_id = "${data.aws_subnets.subnets_public.ids[0]}"
   security_groups = data.aws_security_groups.selected.ids
 }