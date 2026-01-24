# Virtualization Target

QEMU/KVM virtualization with virt-manager GUI.

## Installed Packages

| Package      | Description                                     |
|--------------|-------------------------------------------------|
| virt-manager | GUI for managing virtual machines               |
| qemu-desktop | QEMU hypervisor (x86_64 focused)                |
| libvirt      | Virtualization API and daemon                   |
| edk2-ovmf    | UEFI firmware for VMs                           |
| dnsmasq      | NAT networking for VMs                          |
| swtpm        | Software TPM emulator (required for Windows 11) |

## Post-Install

Log out and back in for `libvirt` group membership to take effect.

Verify with:
```bash
groups | grep libvirt
```

## Usage

### Launch virt-manager
```bash
virt-manager
```

### CLI Management (virsh)

```bash
virsh list --all              # List all VMs
virsh start <vm>              # Start a VM
virsh shutdown <vm>           # Graceful shutdown
virsh destroy <vm>            # Force stop
virsh undefine <vm>           # Delete VM definition
virsh net-list --all          # List networks
```

### Create a New VM

1. Open virt-manager
2. File → New Virtual Machine
3. Select installation media (ISO)
4. Allocate RAM and CPUs
5. Create or select storage disk
6. Configure network (default NAT works for most cases)

### Example: NixOS VM

```bash
# Download NixOS ISO
wget https://channels.nixos.org/nixos-unstable/latest-nixos-minimal-x86_64-linux.iso

# Create VM with virt-install
virt-install \
  --name nixos-test \
  --ram 4096 \
  --disk size=20 \
  --vcpus 2 \
  --os-variant nixos-unstable \
  --cdrom latest-nixos-minimal-x86_64-linux.iso
```

### GPU pass-through

For GPU passthrough, additional setup is required:

1. Enable IOMMU in BIOS (VT-d for Intel, AMD-Vi for AMD)
2. Add kernel parameters: `intel_iommu=on` or `amd_iommu=on`
3. Isolate GPU with VFIO drivers
4. Configure VM XML for PCI passthrough

See: https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF

### Windows 11 VMs

Windows 11 requires TPM 2.0. When creating the VM:

1. Check "Customize configuration before install"
2. Add Hardware → TPM
3. Select "Emulated" with version "2.0"
4. Enable UEFI firmware (OVMF)

### Storage Locations

- VM disk images: `/var/lib/libvirt/images/`
- VM definitions: `/etc/libvirt/qemu/`

### Performance Tips

- Use virtio drivers for disk and network (included in modern Linux, install virtio-win ISO for Windows)
- Enable hugepages for memory-intensive VMs
- Pin vCPUs to physical cores for latency-sensitive workloads
- Use raw disk format instead of qcow2 for maximum performance
