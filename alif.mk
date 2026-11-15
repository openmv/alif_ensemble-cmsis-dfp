# This file is part of the OpenMV project.
#
# Copyright (c) 2013-2021 Ibrahim Abdelkader <iabdalkader@openmv.io>
# Copyright (c) 2013-2021 Kwabena W. Agyeman <kwagyeman@openmv.io>
#
# This work is licensed under the MIT license, see the file LICENSE for details.
#
# Alif Makefile

ALIF_RTSS_CORE := RTSS_$(shell echo $(MCU_CORE) | cut -d_ -f2)
ALIF_RTSS_CORE_DIR := $(shell echo $(ALIF_RTSS_CORE) | tr A-Z a-z)
ALIF_SOC_DIR = $(TOP_DIR)/$(HAL_DIR)/Device/soc/$(MCU_VARIANT)

HAL_SRC_C += \
	drivers/source/adc.c \
	drivers/source/canfd.c \
	drivers/source/crc.c \
	drivers/source/csi.c \
	drivers/source/dma_ctrl.c \
	drivers/source/dma_op.c \
	drivers/source/i2c.c \
	drivers/source/i2s.c \
	drivers/source/i3c.c \
	drivers/source/pdm.c \
	drivers/source/pinconf.c \
	drivers/source/spi.c \
	drivers/source/sys_ctrl_analog.c \
	drivers/source/uart.c \
	drivers/source/utimer.c \
	drivers/source/mhu_driver.c \
	drivers/source/mhu_receiver.c \
	drivers/source/mhu_sender.c \
	drivers/source/mram.c \
	Alif_CMSIS/Source/DPHY_Common.c \
	Alif_CMSIS/Source/DPHY_CSI2.c \
	ospi_xip/source/ospi/ospi_drv.c \
	se_services/source/services_host_application.c \
	se_services/source/services_host_boot.c \
	se_services/source/services_host_clocks.c \
	se_services/source/services_host_power.c \
	se_services/source/services_host_cryptocell.c \
	se_services/source/services_host_handler.c \
	se_services/source/services_host_system.c \
	se_services/source/services_host_maintenance.c \
	Device/core/common/source/cache.c \
	Device/core/common/source/mpu.c \
	Device/core/common/source/pm.c \
	Device/core/common/source/sau_tcm_ns_setup.c \
	Device/core/common/source/startup.c \
	Device/core/common/source/system.c \
	Device/core/common/source/tgu.c \
	Device/core/common/source/vectors.c \
	Device/system/source/sys_clocks.c \
	Device/system/source/sys_utils.c \

ifeq ($(MCU_CORE),M55_HP)
HAL_SRC_C += drivers/source/dcd_alif.c
endif

HAL_CFLAGS += -D$(ALIF_RTSS_CORE)
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/Alif_CMSIS/Include/
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/Alif_CMSIS/Include/config/
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/Alif_CMSIS/Source/
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/drivers/include/
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/ospi_xip/source/ospi/
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/se_services/include
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/Device/core/common/config/
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/Device/core/common/include/
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/Device/core/$(ALIF_RTSS_CORE_DIR)/config/
HAL_CFLAGS += -I$(TOP_DIR)/$(HAL_DIR)/Device/system/include/
HAL_CFLAGS += -I$(ALIF_SOC_DIR)/config/
HAL_CFLAGS += -I$(ALIF_SOC_DIR)/include/
HAL_CFLAGS += -I$(ALIF_SOC_DIR)/include/$(ALIF_RTSS_CORE_DIR)/
HAL_CFLAGS += -I$(ALIF_SOC_DIR)/rte/

OMV_FIRM_OBJ += $(addprefix $(BUILD)/$(HAL_DIR)/, $(HAL_SRC_C:.c=.o))

$(BUILD)/$(HAL_DIR)/drivers/source/spi.o: override CFLAGS += -Wno-maybe-uninitialized
$(BUILD)/$(HAL_DIR)/drivers/source/i3c.o: override CFLAGS += -Wno-int-conversion
$(BUILD)/$(HAL_DIR)/Alif_CMSIS/Source/DPHY_CSI2.o: override CFLAGS += -Wno-unused-function
$(BUILD)/$(HAL_DIR)/drivers/source/mram.o: override CFLAGS += -Wno-strict-aliasing
$(BUILD)/$(HAL_DIR)/se_services/source/services_host_boot.o: override CFLAGS += -Wno-stringop-truncation
$(BUILD)/$(HAL_DIR)/se_services/source/services_host_system.o: override CFLAGS += -Wno-maybe-uninitialized
