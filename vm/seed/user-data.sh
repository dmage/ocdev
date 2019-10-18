#!/bin/sh
cat <<END
#cloud-config
system_info:
  default_user:
    name: cloud
chpasswd:
  list: |
    cloud:qwerty
  expire: False
resize_rootfs: True
ssh_pwauth: True
ssh_authorized_keys:
- $(cat ~/.ssh/id_rsa.pub)
END
