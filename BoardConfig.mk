#
# Copyright (C) 2022 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/motorola/rtwo

# Inherit from motorola sm8550-common
include device/motorola/sm8550-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := rtwo

# Display
TARGET_SCREEN_DENSITY := 400

# HIDL
DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/device_framework_matrix_rtwo.xml
DEVICE_MANIFEST_KALAMA_FILES += $(DEVICE_PATH)/manifest_rtwo.xml
ODM_MANIFEST_SKUS += dn dne
ODM_MANIFEST_DN_FILES := $(DEVICE_PATH)/manifest_rtwo_dn.xml
ODM_MANIFEST_DNE_FILES := $(DEVICE_PATH)/manifest_rtwo_dne.xml

# Kernel
TARGET_KERNEL_CONFIG += \
	vendor/ext_config/moto-kalama-rtwo.config

# Kernel Modules
BOARD_SYSTEM_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modules.load.system_dlkm))
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.system_dlkm))
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load))
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.vendor_boot))
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(DEVICE_PATH)/modules.blocklist.vendor_boot
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery))
BOOT_KERNEL_MODULES := $(strip $(shell cat $(DEVICE_PATH)/modules.load.recovery $(DEVICE_PATH)/modules.load.vendor_ramdisk))

TARGET_KERNEL_EXT_MODULES := \
  qcom/mmrm-driver \
  qcom/mm-drivers/hw_fence \
  qcom/mm-drivers/msm_ext_display \
  qcom/mm-drivers/sync_fence \
  qcom/audio-kernel \
  qcom/camera-kernel \
  qcom/dataipa/drivers/platform/msm \
  qcom/datarmnet/core \
  qcom/datarmnet-ext/aps \
  qcom/datarmnet-ext/offload \
  qcom/datarmnet-ext/shs \
  qcom/datarmnet-ext/perf \
  qcom/datarmnet-ext/perf_tether \
  qcom/datarmnet-ext/sch \
  qcom/datarmnet-ext/wlan \
  qcom/securemsm-kernel \
  qcom/display-drivers/msm \
  qcom/eva-kernel \
  qcom/video-driver \
  qcom/graphics-kernel \
  qcom/wlan/platform \
  qcom/wlan/qcacld-3.0/.kiwi_v2 \
  qcom/bt-kernel \
  nxp/driver \
  motorola/drivers/mmi_annotate \
  motorola/drivers/mmi_info \
  motorola/drivers/power/bm_adsp_ulog \
  motorola/drivers/power/mmi_charger \
  motorola/drivers/power/qti_glink_charger \
  motorola/drivers/power/qpnp_adaptive_charge \
  motorola/drivers/misc/utag \
  motorola/drivers/mmi_relay \
  motorola/drivers/power/mmi_lpd_mitigate \
  motorola/drivers/moto_f_usbnet \
  motorola/drivers/misc/mmi_sys_temp \
  motorola/drivers/power/wakeup_sources \
  motorola/drivers/watchdogtest \
  motorola/drivers/regulator/wl2868c \
  motorola/drivers/sensors \
  motorola/drivers/misc/sx937x_multi \
  motorola/drivers/input/touchscreen/touchscreen_mmi \
  motorola/drivers/input/touchscreen/goodix_berlin_mmi \
  motorola/drivers/input/misc/goodix_fod_mmi

# Partitions
BOARD_USERDATAIMAGE_PARTITION_SIZE := 230140391424
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 3318226944
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 873680896
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 916299776
endif
BOARD_MOT_DP_GROUP_SIZE := 9936306176 # ( BOARD_SUPER_PARTITION_SIZE - 4MB )
BOARD_SUPER_PARTITION_SIZE := 9940500480

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90

# Security
VENDOR_SECURITY_PATCH := 2023-08-01

# inherit from the proprietary version
include vendor/motorola/rtwo/BoardConfigVendor.mk
