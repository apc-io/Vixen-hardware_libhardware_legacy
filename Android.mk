# Copyright 2006 The Android Open Source Project

# Setting LOCAL_PATH will mess up all-subdir-makefiles, so do it beforehand.
legacy_modules := power uevent vibrator wifi_realtek qemu qemu_tracing

SAVE_MAKEFILES := $(call all-named-subdir-makefiles,$(legacy_modules))
LEGACY_AUDIO_MAKEFILES := $(call all-named-subdir-makefiles,audio)

legacy_modules_realtek := power uevent vibrator wifi_realtek qemu qemu_tracing
SAVE_MAKEFILES_realtek := $(call all-named-subdir-makefiles,$(legacy_modules_realtek))
LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES += libhardware_legacy_mtk6620.so:system/lib/libhardware_legacy_mtk6620.so
LOCAL_SRC_FILES += libhardware_legacy_mtk6620.so:obj/SHARED_LIBRARIES/libhardware_legacy_mtk6620_intermediates/LINKED/libhardware_legacy_mtk6620.so
LOCAL_SRC_FILES += libhardware_legacy_mtk6620.so:symbols/system/lib/libhardware_legacy_mtk6620.so
LOCAL_SRC_FILES += libhardware_legacy_mtk6620.so:obj/lib/libhardware_legacy_mtk6620.so
LOCAL_SRC_FILES += export_includes:obj/SHARED_LIBRARIES/libhardware_legacy_mtk6620_intermediates/export_includes
include $(WMT_PREBUILT)


include $(CLEAR_VARS)

LOCAL_SHARED_LIBRARIES := libcutils libwpa_client

LOCAL_INCLUDES += $(LOCAL_PATH)

LOCAL_CFLAGS  += -DQEMU_HARDWARE
QEMU_HARDWARE := true

LOCAL_SHARED_LIBRARIES += libdl

include $(SAVE_MAKEFILES)

LOCAL_MODULE:= libhardware_legacy

include $(BUILD_SHARED_LIBRARY)
#################realteck##############################

include $(CLEAR_VARS)

LOCAL_SHARED_LIBRARIES := libcutils libwpa_client

LOCAL_INCLUDES += $(LOCAL_PATH)

LOCAL_CFLAGS  += -DQEMU_HARDWARE
QEMU_HARDWARE := true

LOCAL_SHARED_LIBRARIES += libdl

include $(SAVE_MAKEFILES_realtek)
LOCAL_MODULE:= libhardware_legacy_rtl
include $(BUILD_SHARED_LIBRARY)

# static library for librpc
include $(CLEAR_VARS)

LOCAL_MODULE:= libpower

LOCAL_SRC_FILES += power/power.c

include $(BUILD_STATIC_LIBRARY)

# shared library for various HALs
include $(CLEAR_VARS)

LOCAL_MODULE := libpower

LOCAL_SRC_FILES := power/power.c

LOCAL_SHARED_LIBRARIES := libcutils

include $(BUILD_SHARED_LIBRARY)

# legacy_audio builds it's own set of libraries that aren't linked into
# hardware_legacy
include $(LEGACY_AUDIO_MAKEFILES)
