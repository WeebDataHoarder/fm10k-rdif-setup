# FM10K + rdif setup
These colection of scripts help setup of rdif with FM10K kernel module with UIO for Silicom cards.

Cards tested:
* Silicom PE3100G2DQIRM-QX4


## Installation and setup
* Install build tools `# apt install build-essential`
* Install Linux kernel headers
 * Debian/Ubuntu: `# apt install linux-headers`
 * Proxmox: `# apt install pve-headers`
* Execute setup.sh `# ./setup.sh`
 * This will compile fm10k kernel module with UIO support for running rdif switch manager.
 * It will obtain a copy rdif from IPFS by hash, if you don't have the same local, then build it.
 * rdif will be stopped and kernel module fm10k reloaded
 * Default fm_platform_attributes.cfg will be placed under `/etc/rdi/fm_platform_attributes.cfg` if folder doesn't exist.

## Mapping PCIe devices to fm10k driver
* It is always a good idea to set up IOMMU in your kernel cmdline GRUB_CMDLINE_LINUX_DEFAULT `intel_iommu=on iommu=pt`.
* (optional) Probably you also want hugepages! DPDK and similar want them badly.
* Use `# lshw -c network -businfo` to find the PCIe bus of the given devices.
* Map it permanently using for example `# driverctl set-override 0000:01:00.0 fm10k` for listed device `pci@0000:01:00.0`.
* If needed, `# rmmod fm10k` and `# modprobe fm10k` to reload the module.

## Running rdif
* See `src/rdif/readme.txt` once available.
* To start: `# rdif start`
* To stop: `# rdif stop`
* Control it via `rdifctl`
* An example exists under `./mask_as_switch.sh` that connects all ports under the same bridge.

## Troubleshooting
* Check the device platform README for notes.
* Make sure you don't have another IES (_Intel(R) Ethernet Switch (IES) Software API_) instance running elsewhere.
* Check that FM_LIBERTY_TRAIL_CONFIG_FILE is not set, or if set, that is where platform configuration files will get searched at.