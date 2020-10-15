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

## Running rdif
* See `src/rdif/readme.txt` once available.
* To start: `# rdif start`
* To stop: `# rdif stop`
* Control it via `rdifctl`
* An example exists under `./mask_as_switch.sh` that connects all ports under the same bridge.