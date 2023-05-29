#
# Copyright (C) 2022-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Screen
TARGET_SCREEN_DENSITY := 400

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := 400dpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

BOARD_SHIPPING_API_LEVEL := 33
BOARD_API_LEVEL := 33
PRODUCT_SHIPPING_API_LEVEL := 33

# Inherit from motorola sm8550-common
$(call inherit-product, device/motorola/sm8550-common/common.mk)

# Overlay
PRODUCT_PACKAGES += \
    FrameworksResRtwo \
    LineageSystemUIRtwo \
    SettingsProviderResRtwo \
    SystemUIResRtwo

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/sku_kalama/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_kalama/audio_effects.xml \
    $(LOCAL_PATH)/audio/sku_kalama/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_kalama/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/sku_kalama/audio_policy_configuration_a2dp_offload_disabled.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_kalama/audio_policy_configuration_a2dp_offload_disabled.xml \
    $(LOCAL_PATH)/audio/sku_kalama/mixer_paths_kalama_mtp_wsa883x_nohdr.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_kalama/mixer_paths_kalama_mtp_wsa883x_nohdr.xml \
    $(LOCAL_PATH)/audio/sku_kalama/mixer_paths_kalama_mtp_wsa883x.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_kalama/mixer_paths_kalama_mtp_wsa883x.xml \
    $(LOCAL_PATH)/audio/sku_kalama/resourcemanager_kalama_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_kalama/resourcemanager_kalama_mtp.xml \
    $(LOCAL_PATH)/audio/sku_kalama_qssi/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_kalama_qssi/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    $(LOCAL_PATH)/audio/audio_ext_spkr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_ext_spkr.conf \
    $(LOCAL_PATH)/audio/card-defs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/card-defs.xml \
    $(LOCAL_PATH)/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/audio/microphone_characteristics.xml:$(TARGET_COPY_OUT_VENDOR)/etc/microphone_characteristics.xml \
    $(LOCAL_PATH)/audio/usecaseKvManager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usecaseKvManager.xml

# Init
$(foreach f,$(wildcard $(LOCAL_PATH)/rootdir/etc/init/hw/*.rc),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/$(notdir $f)))
$(foreach f,$(wildcard $(LOCAL_PATH)/rootdir/etc/init/*.rc),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/etc/init/$(notdir $f)))
$(foreach f,$(wildcard $(LOCAL_PATH)/rootdir/bin/*.sh),\
        $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_VENDOR)/bin/$(notdir $f)))

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_profiles_kalama.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_kalama.xml

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.2.vendor \
    android.hardware.secure_element@1.2.vendor \
    com.android.nfc_extras \
    libchrome.vendor \
    NfcNci \
    SecureElement \
    Tag

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_dne/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_dne/android.hardware.se.omapi.ese.xml

# PowerShare
PRODUCT_PACKAGES += \
    vendor.lineage.powershare@1.0-service.rtwo

# Sensors
PRODUCT_PACKAGES += \
    sensors.rtwo

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Touch
# PowerShare
PRODUCT_PACKAGES += \
    vendor.lineage.touch@1.0-service.rtwo

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# Inherit from vendor blobs
$(call inherit-product, vendor/motorola/rtwo/rtwo-vendor.mk)
