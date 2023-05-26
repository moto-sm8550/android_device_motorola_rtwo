#
# Copyright (C) 2022-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/motorola/rtwo

# Inherit from motorola sm8550-common
include device/motorola/sm8550-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := rtwo

# Fingerprint
#TARGET_SURFACEFLINGER_UDFPS_LIB := //$(DEVICE_PATH):libudfps_extension.rtwo
#SOONG_CONFIG_qtidisplay_udfps := true

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/device_framework_matrix_rtwo.xml
DEVICE_MANIFEST_FILE += $(DEVICE_PATH)/manifest_rtwo.xml
ODM_MANIFEST_SKUS += dne
ODM_MANIFEST_DNE_FILES := $(DEVICE_PATH)/manifest_rtwo_ese.xml

# Kernel
TARGET_KERNEL_CONFIG += \
	vendor/ext_config/moto-kalama-rtwo.config \
	vendor/ext_config/lineage-moto-kalama-rtwo.config

TARGET_KERNEL_DIR := $(DEVICE_PATH)-kernel
KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)/modules

BOARD_PREBUILT_DTBIMAGE_DIR := $(TARGET_KERNEL_DIR)
BOARD_PREBUILT_DTBOIMAGE := $(TARGET_KERNEL_DIR)/dtbo.img
TARGET_PREBUILT_KERNEL := $(TARGET_KERNEL_DIR)/kernel

# Kernel Modules
KERNEL_MODULES := $(wildcard $(KERNEL_MODULE_DIR)/*.ko)

BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_MODULE_DIR)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_MODULE_DIR)/modules.blocklist

BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist.vendor_boot

BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))

BOARD_VENDOR_KERNEL_MODULES := $(KERNEL_MODULES)
BOARD_VENDOR_RAMDISK_KERNEL_MODULES := $(addprefix $(KERNEL_MODULE_DIR)/, $(notdir $(BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD)))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_ARCHIVE := $(KERNEL_MODULE_DIR)/vendor_ramdisk_include.zip

# Partitions
BOARD_USERDATAIMAGE_PARTITION_SIZE := 228362006528
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 3318226944
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 873680896
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 916299776
endif
BOARD_MOT_DP_GROUP_SIZE := 11806965760 # ( BOARD_SUPER_PARTITION_SIZE - 4MB )
BOARD_SUPER_PARTITION_SIZE := 11811160064

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90

# Security
VENDOR_SECURITY_PATCH := 2022-12-01

# inherit from the proprietary version
include vendor/motorola/rtwo/BoardConfigVendor.mk
