/* SPDX-License-Identifier: GPL-2.0 */
/* Copyright(c) 2013 - 2019 Intel Corporation. */

/* glue for the OS independent part of fm10k
 * includes register access macros
 */

#ifndef _FM10K_OSDEP_H_
#define _FM10K_OSDEP_H_
#include "kcompat.h"

/* forward declaration */
struct fm10k_hw;

#define FM10K_REMOVED(hw_addr) unlikely(!(hw_addr))

/* PCI configuration read */
u16 fm10k_read_pci_cfg_word(struct fm10k_hw *hw, u32 reg);

/* read operations, indexed using DWORDS */
u32 fm10k_read_reg(struct fm10k_hw *hw, int reg);

/* write operations, indexed using DWORDS */
#define fm10k_write_reg(hw, reg, val) \
do { \
	u32 __iomem *hw_addr = READ_ONCE((hw)->hw_addr); \
	if (!FM10K_REMOVED(hw_addr)) \
		writel((val), &hw_addr[(reg)]); \
} while (0)

/* Switch register write operations, index using DWORDS */
#define fm10k_write_sw_reg(hw, reg, val) \
do { \
	u32 __iomem *sw_addr = READ_ONCE((hw)->sw_addr); \
	if (!FM10K_REMOVED(sw_addr)) \
		writel((val), &sw_addr[(reg)]); \
} while (0)

/* read ctrl register which has no clear on read fields as PCIe flush */
#define fm10k_write_flush(hw) fm10k_read_reg((hw), FM10K_CTRL)

#endif /* _FM10K_OSDEP_H_ */
