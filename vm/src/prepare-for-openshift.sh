#!/bin/sh -eux

sudo mkdir -p /etc/docker
sudo sh -c 'cat >/etc/docker/daemon.json' <<END
{
    "insecure-registries": ["172.30.0.0/16"]
}
END

sudo mkdir -p /etc/systemd/system/docker.service.d
sudo sh -c 'cat >/etc/systemd/system/docker.service.d/override.conf' <<'END'
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd-current \
          --add-runtime oci=/usr/libexec/docker/docker-runc-current \
          --default-runtime=oci \
          --authorization-plugin=rhel-push-plugin \
          --containerd /run/containerd.sock \
          --exec-opt native.cgroupdriver=cgroupfs \
          --userland-proxy-path=/usr/libexec/docker/docker-proxy-current \
          --init-path=/usr/libexec/docker/docker-init-current \
          --seccomp-profile=/etc/docker/seccomp.json \
          $OPTIONS \
          $DOCKER_STORAGE_OPTIONS \
          $DOCKER_NETWORK_OPTIONS \
          $ADD_REGISTRY \
          $BLOCK_REGISTRY \
          $INSECURE_REGISTRY \
          $REGISTRIES
END

sudo dnf install -y docker

sudo systemctl daemon-reload
sudo systemctl start docker

for i in 1 2 3 4 5; do
    ! test -e /var/run/docker.sock || break
    sleep 0.5
done
sudo chmod 777 /var/run/docker.sock
