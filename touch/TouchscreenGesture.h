/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include <vendor/lineage/touch/1.0/ITouchscreenGesture.h>

#include <map>

namespace {
struct GestureInfo {
    int32_t keycode;
    const char* name;
    const char* path;
    const char* enable;
    const char* disable;
};

constexpr GestureInfo kGestureNodes[] = {
        {59,
         "Single Tap",
         "/sys/class/touchscreen/primary/gesture",
         "33", "32"},
};
}  // anonymous namespace

namespace vendor {
namespace lineage {
namespace touch {
namespace V1_0 {
namespace implementation {

using ::android::hardware::Return;
using ::android::hardware::Void;

class TouchscreenGesture : public ITouchscreenGesture {
   public:
    // Methods from ::vendor::lineage::touch::V1_0::ITouchscreenGesture follow.
    Return<void> getSupportedGestures(getSupportedGestures_cb resultCb) override;
    Return<bool> setGestureEnabled(
        const ::vendor::lineage::touch::V1_0::Gesture& gesture, bool enable) override;

   private:
    std::map<int32_t, GestureInfo> kGestureInfoMap;
};

}  // namespace implementation
}  // namespace V1_0
}  // namespace touch
}  // namespace lineage
}  // namespace vendor
