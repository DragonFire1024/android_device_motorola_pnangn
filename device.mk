#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2020 The TWRP Open Source Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generator
# Copyright (C) 2022-juic3b0x
#

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Enable virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

LOCAL_PATH := device/motorola/pnangn

# API
BOARD_SHIPPING_API_LEVEL := 30
BOARD_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31
SHIPPING_API_LEVEL := 31

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

PRODUCT_PACKAGES += \
    bootctrl.holi

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-impl-qti.recovery \
    bootctrl.holi.recovery

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

PRODUCT_PACKAGES += \
    sg_write_buffer \
    f2fs_io \
    check_f2fs

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Screen
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/qcom-caf/bootctrl \
    vendor/qcom/opensource/commonsys-intf/display

# Update engine
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

# TWRP Configuration
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_HAS_MTP := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_REPACKTOOLS := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 180
TW_MAX_BRIGHTNESS := 255
TW_Y_OFFSET := 80
TW_H_OFFSET := -80
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true
TW_NO_SCREEN_BLANK := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_EXCLUDE_APEX := true

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_QCOM_FBE_DECRYPTION := true
TW_USE_FSCRYPT_POLICY := 2
TW_FIX_DECRYPTION_ON_DATA_MEDIA := true

TW_LOAD_VENDOR_MODULES := "moto_f_usbnet.ko nova_0flash_mmi.ko mmi-smbcharger-iio.ko qpnp_adaptive_charge.ko utags.ko"

TARGET_RECOVERY_DEVICE_MODULES += \
    libandroidicu \
    libdisplayconfig.qti \
    libion \
    vendor.display.config@1.0 \
    vendor.display.config@2.0 \
    libdisplayconfig.qti

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/lib/modules/moto_f_usbnet.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/moto_f_usbnet.ko \
    $(LOCAL_PATH)/lib/modules/nova_0flash_mmi.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/nova_0flash_mmi.ko \
    $(LOCAL_PATH)/lib/modules/utags.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/utags.ko \
    $(LOCAL_PATH)/lib/modules/qpnp_adaptive_charge.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/qpnp_adaptive_charge.ko \
    $(LOCAL_PATH)/lib/modules/5.4-gki/moto_f_usbnet.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/5.4-gki/moto_f_usbnet.ko \
    $(LOCAL_PATH)/lib/modules/5.4-gki/nova_0flash_mmi.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/5.4-gki/nova_0flash_mmi.ko \
    $(LOCAL_PATH)/lib/modules/5.4-gki/qpnp_adaptive_charge.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/5.4-gki/qpnp_adaptive_charge.ko \
    $(LOCAL_PATH)/lib/modules/5.4-gki/utags.ko:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib/modules/5.4-gki/utags.ko

RECOVERY_LIBRARY_SOURCE_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/libdisplayconfig.qti.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/libandroidicu.so:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/lib64/libandroidicu.so \
    $(LOCAL_PATH)/prebuilt/android.hardware.boot@1.0-impl-1.1-qti.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/hw/android.hardware.boot@1.0-impl-1.1-qti.so \
    $(LOCAL_PATH)/prebuilt/librecovery_updater_msm.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/librecovery_updater_msm.so \
    $(LOCAL_PATH)/prebuilt/libboot_control_qti.so:$(TARGET_COPY_OUT_RECOVERY)/root/system/lib64/libboot_control_qti.so

PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe
