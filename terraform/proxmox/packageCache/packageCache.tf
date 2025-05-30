resource "proxmox_vm_qemu" "packageCache" {
    count       = 1
    name        = "SVR-packageCache"
    target_node = "pve"
    clone       = "Alma-9.4-Template"
    full_clone  = true
    agent       = 1

    memory      = 2048
    cores       = 2
    sockets     = 1
    scsihw      = "virtio-scsi-pci"
    qemu_os     = "l26"
    cpu         = "x86-64-v2-AES"

    vm_state    = "running"
    tags        = ""

    provisioner "remote-exec" {
      inline = ["echo 'SVR-packageCache' > /etc/hostname"]

      connection {
        host        = self.default_ipv4_address
        type        = "ssh"
        user        = "root"
        private_key = file(var.pvt_key)
    }
}

    provisioner "local-exec" {
      command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.default_ipv4_address},' --private-key ${var.pvt_key} -e 'pub_key=${var.pub_key}' ../../../ansible/packageCache.yaml"
  }

    network {
        bridge  = "vmbr0"
        model   = "virtio"
        tag     = 252
    }
}

output "proxmox_ip_address_default" {
  description = "Current IP Default"
  value = proxmox_vm_qemu.packageCache.*.default_ipv4_address
}