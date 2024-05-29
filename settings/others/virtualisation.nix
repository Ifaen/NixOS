{
  config,
  pkgs,
  user,
  ...
}:
# Do sudo virsh net-autostart default to allow NAT for virt-manager
let
  vm-name = "win10";
in {
  boot = {
    # Adds those lines in the bootloader (being grub, systemd-boot or refind)
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
      #"video=efif:off"
      #"disable_idle_d3=1"
    ];

    # Virtual function for PCI Express
    kernelModules = [
      "vfio"
      "vfio-pci"
      "vfio_iommu_type1"
      "vfio_virqfd"
    ];
  };

  programs = {
    dconf.enable = true; # System Management Tool
    virt-manager.enable = true; # QEMU / virt-manager
  };

  virtualisation.libvirtd = {
    enable = true; # virt-manager / qemu

    onBoot = "ignore"; # Prevent from starting guests that were not closed when host was shutdown
    onShutdown = "shutdown"; # Setting to "shutdown" will cause an ACPI shutdown of each guest. "suspend" will attempt to save the state of the guests ready to restore on boot.

    qemu = {
      swtpm.enable = false; # Software Trusted Platform Module. Provides cryptographic functionalities such as secure storage of keys, remote attestation, and sealing/unsealing data
      # Open Virtual Machine Firmware. Provides UEFI support for Virtual Machines
      ovmf = {
        enable = true;
        packages = [pkgs.OVMFFull.fd];
      };
    };

    hooks.qemu."${vm-name}-gpu-passthrough" = "${
      pkgs.writeShellScript "${vm-name}-gpu-passthrough.sh" ''
        function prepare() {
          # Stop display manager
          systemctl stop display-manager.service

          # Avoid a Race condition by waiting 2 seconds. This can be calibrated to be shorter or longer if required for your system
          sleep 10
        }

        function release() {
          systemctl start display-manager.service # Restart Display Manager
        }

        if [ "$1" == "${vm-name}" ]; then
          case $2 in
            prepare)
              if [ "$3" == "begin" ]; then
                prepare
              fi
            ;;
            release)
              if [ "$3" == "end" ]; then
                release
              fi
            ;;
          esac
        fi
      ''
    }";
  };

  environment.systemPackages = with pkgs; [
    virtiofsd
    libguestfs
  ]; # needed to virt-sparsify qcow2 files

  users.users.${user.name}.extraGroups = ["libvirtd"]; # To use virt-manager as normal user

  home-manager.users.${user.name} = {
    # Configuration for virt-manager
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
    programs.waybar.settings.statusBar."hyprland/workspaces".window-rewrite."class<virt-manager>" = ""; # nf-cod-vm_connect
  };

  /*
  services.openssh = {
    enable = false;
    # require public key authentication for better security
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  */
}
