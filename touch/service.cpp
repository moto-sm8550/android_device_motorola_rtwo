/*
 * SPDX-FileCopyrightText: The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

#define LOG_TAG "lineage.touch@1.0-service.lge_msmnile"

#include <android-base/logging.h>
#include <hidl/HidlTransportSupport.h>

#include "HighTouchPollingRate.h"
#include "TouchscreenGesture.h"

using ::vendor::lineage::touch::V1_0::IHighTouchPollingRate;
using ::vendor::lineage::touch::V1_0::ITouchscreenGesture;
using ::vendor::lineage::touch::V1_0::implementation::HighTouchPollingRate;
using ::vendor::lineage::touch::V1_0::implementation::TouchscreenGesture;

int main() {
    android::sp<IHighTouchPollingRate> highTouchPollingRate = new HighTouchPollingRate();
    android::sp<ITouchscreenGesture> touchscreenGesture = new TouchscreenGesture();

    android::hardware::configureRpcThreadpool(1, true /*callerWillJoin*/);

    if (highTouchPollingRate->registerAsService() != android::OK) {
        LOG(ERROR) << "Cannot register touchscreen glove HAL service.";
        return 1;
    }

    if (touchscreenGesture->registerAsService() != android::OK) {
        LOG(ERROR) << "Cannot register touchscreen gesture HAL service.";
        return 1;
    }

    LOG(INFO) << "Touchscreen HAL service ready.";

    android::hardware::joinRpcThreadpool();

    LOG(ERROR) << "Touchscreen HAL service failed to join thread pool.";
    return 1;
}
