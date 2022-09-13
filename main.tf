resource "openstack_compute_instance_v2" "pyluks-master" {
  name            = "pyluks-master"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.keypair
  security_groups = var.secgroups
  network {
    name = var.network_name
  }
}

resource "openstack_blockstorage_volume_v2" "pyluks-volume" {
  name = var.volume_name
  size = var.volume_size
}

resource "openstack_compute_volume_attach_v2" "pyluks-volume" {
  instance_id = openstack_compute_instance_v2.pyluks-master.id
  volume_id   = openstack_blockstorage_volume_v2.pyluks-volume.id
  device      = var.device
}

resource "openstack_networking_floatingip_v2" "fip-master" {
  pool = var.pool
}

resource "openstack_compute_floatingip_associate_v2" "fip-master" {
  instance_id = openstack_compute_instance_v2.pyluks-master.id
  floating_ip = openstack_networking_floatingip_v2.fip-master.address
}

resource "openstack_compute_instance_v2" "pyluks-worker" {
  name            = "pyluks-worker"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.keypair
  security_groups = var.secgroups
  network {
    name = var.network_name
  }
}

resource "openstack_networking_floatingip_v2" "fip-worker" {
  pool = var.pool
}

resource "openstack_compute_floatingip_associate_v2" "fip-worker" {
  instance_id = openstack_compute_instance_v2.pyluks-worker.id
  floating_ip = openstack_networking_floatingip_v2.fip-worker.address
}

output "master" {
  description = "IP of master"
  value       = openstack_networking_floatingip_v2.fip-master.address
}

output "worker" {
  description = "IP of worker"
  value       = openstack_networking_floatingip_v2.fip-worker.address
}
