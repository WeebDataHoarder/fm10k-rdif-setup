#!/bin/bash

# Sets the mappings for the device to act as every port being part of same switch

# 6-port devices
rdifctl set_port_mask 1 2,3,4,5,6
rdifctl set_port_mask 2 1,3,4,5,6
rdifctl set_port_mask 3 1,2,4,5,6
rdifctl set_port_mask 4 1,2,3,5,6
rdifctl set_port_mask 5 1,2,3,4,6
rdifctl set_port_mask 6 1,2,3,4,5

# 4-port devices
#rdifctl set_port_mask 1 2,3,4
#rdifctl set_port_mask 2 1,3,4
#rdifctl set_port_mask 3 1,2,4
#rdifctl set_port_mask 4 1,2,3