#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

import subprocess
from os import path

from extract_utils.args import (
    parse_args,
)
from extract_utils.extract import extract_fns_user_type
from extract_utils.extract_star import extract_star_firmware
from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.tools import (
    lineage_scripts_dir,
)

namespace_imports = [
    'device/motorola/sm8550-common',
    'vendor/motorola/sm8550-common',
    'hardware/qcom-caf/sm8550',
    'hardware/qcom-caf/wlan',
    'hardware/motorola',
    'vendor/qcom/opensource/commonsys-intf/display',
    'vendor/qcom/opensource/commonsys/display',
    'vendor/qcom/opensource/dataservices',
    'vendor/qcom/opensource/display',
]

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
}

blob_fixups: blob_fixups_user_type = {
    'vendor/lib64/libgf_hal.so': blob_fixup()
        .replace_needed('vendor.goodix.hardware.biometrics.fingerprint@2.1_vendor.so', 'vendor.goodix.hardware.biometrics.fingerprint@2.1.so'),
    'vendor/lib64/libmot_chi_desktop_helper.so': blob_fixup()
        .add_needed('libgui_buffer_shim_vendor.so'),
    'vendor/lib64/nfc_nci.nqx.default.hw.so': blob_fixup()
    .add_needed('libbase_shim.so'),
    (
        'vendor/bin/hw/vendor.qti.camera.provider-service_64',
        'vendor/lib64/camx.provider-impl.so',
    ): blob_fixup()
        .replace_needed('libtinyxml2.so', 'libtinyxml2-v34.so')
}  # fmt: skip

extract_fns: extract_fns_user_type = {
    r'(bootloader|radio)\.img': extract_star_firmware,
}

module = ExtractUtilsModule(
    'rtwo',
    'motorola',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    extract_fns=extract_fns,
    add_firmware_proprietary_file=True,
    add_generated_carriersettings=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(
        module, 'sm8550-common', module.vendor
    )
    utils.run()

    args = parse_args()
    if args.source and args.source != 'adb':
        source = args.source[0] if isinstance(args.source, list) else args.source
        info_script = path.join(lineage_scripts_dir, 'motorola', 'info.sh')
        if path.isfile(info_script):
            subprocess.run([info_script, source])
