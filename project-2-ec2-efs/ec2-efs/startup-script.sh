#!/bin/bash
sudo echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDsdmIxTLNKXHcOgc0RiVIeLCafPK+FJJWpySvuCmRYNCnn2Yf8v3nnR+28KmZBb6sym2spji3i9YDaH2DaiHw5IMKlZQ8gWd25vZeyxGtyi8AURhgOtyqKIdiPbC3+uG8iqxDDp7E3lJbkIfTfxB/+ETwMXJn3cPYs4oev42oNwRvDRm2zFeGp+xP5B4u8UqnT5smuPved+0lvNICtXMMb6Kr/zIo0NXfX4HrB5yvc/sF2JP9DFUXUDQPLWrnWXXucKV4ptcg5u7RBCd9CYKwXtM25JfeWN/d7XKGD26m36incLdJCkDqdS1z+tmvpYc1DiLQK+7P7sahcJmZ1MVXp6WuLpAlNlHJ2hZ6n63tG/noopi6mADxbj5MKUix9sojr9LAPUz4bh29oQ1tQENv/i1XYrrzqks3CJ5ADg6RE8skAQni/g86+vtk2NEKUsHkSb0Ox6djFJHdsPVByO6Cr0lKu5tTk47ujQQcFO6KHPTzLljeLorsfsSjBnCbeKac= whyrstack@X" >> /home/ec2-user/.ssh/authorized_keys


# Ref: https://docs.aws.amazon.com/efs/latest/ug/wt1-test.html
sudo yum update -y
sudo yum -y install nfs-utils

mkdir /efs-mount-point 
sudo chmod 766 /efs-mount-point
sudo echo "fs-0c96fd86c774b2fc0.efs.eu-central-1.amazonaws.com:/ /efs-mount-point nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,_netdev 0 0" >> /etc/fstab
