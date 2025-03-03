/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "TouchscreenGestureService"

#include <fstream>

#include <android-base/file.h>
#include <android-base/logging.h>

#include "TouchscreenGesture.h"

namespace vendor {
namespace lineage {
namespace touch {
namespace V1_0 {
namespace implementation {

Return<void> TouchscreenGesture::getSupportedGestures(getSupportedGestures_cb resultCb) {
    std::vector<Gesture> gestures;
    for (int32_t i = 0; i < std::size(kGestureNodes); ++i) {
        gestures.push_back({i, kGestureNodes[i].name, kGestureNodes[i].keycode});
    }
    resultCb(gestures);
    return Void();
}

Return<bool> TouchscreenGesture::setGestureEnabled(
    const ::vendor::lineage::touch::V1_0::Gesture& gesture, bool enable) {
    if (gesture.id >= std::size(kGestureNodes)) {
        return false;
    }

    if (!android::base::WriteStringToFile(enable ? kGestureNodes[gesture.id].enable : kGestureNodes[gesture.id].disable,
                                          kGestureNodes[gesture.id].path)) {
        LOG(ERROR) << "Writing to file " << kGestureNodes[gesture.id].path << " failed";
        return false;
    }

    return true;
}

}  // namespace implementation
}  // namespace V1_0
}  // namespace touch
}  // namespace lineage
}  // namespace vendor
