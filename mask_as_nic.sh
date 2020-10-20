#!/bin/bash

# Sets the mappings for the device to act as two internal ports split for each external port (NIC: 1x100G -> 2x50G)
# Later on you can bond them, or use independently.

# 6-port devices
# QSFP 0
rdifctl set_port_mask 1 3,5
rdifctl set_port_mask 3 1
rdifctl set_port_mask 5 1

# QSFP 1
rdifctl set_port_mask 2 4,6
rdifctl set_port_mask 4 2
rdifctl set_port_mask 6 2

# 4-port devices
# QSFP 0
#rdifctl set_port_mask 1 3
#rdifctl set_port_mask 3 1

# QSFP 1
#rdifctl set_port_mask 2 4
#rdifctl set_port_mask 4 2