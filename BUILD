# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Description:
#  DarwiNN Runtime Libaries.

package(default_visibility = ["//visibility:public"])

# All Google Owned Code except :
# - certain files in port/default/ that are under Apache 2.0 license.
licenses(["notice"])

exports_files([
    "LICENSE",
])

config_setting(
    name = "opt",
    values = {
        "compilation_mode": "opt",
    },
)

# If --define darwinn_portable=1, compile without google3 deps.
config_setting(
    name = "darwinn_portable",
    values = {
        "define": "darwinn_portable=1",
    },
)

# If --define darwinn_portable=1 AND this is an otherwise non-portable config.
config_setting(
    name = "darwinn_portable_with_non_portable_os",
    flag_values = {"//tools/cpp:cc_target_os": "linux-google"},
    values = {"define": "darwinn_portable=1"},
)

# If --define darwinn_firmware=1, compile with minimal deps.
config_setting(
    name = "darwinn_firmware",
    values = {
        "define": "darwinn_firmware=1",
    },
)

config_setting(
    name = "windows",
    values = {
        "cpu": "x64_windows",
    },
)

config_setting(
    name = "darwin",
    values = {
        "cpu": "darwin",
    },
)

# Target platforms for the legacy GNU cross builds. The compiler still comes from
# --crosstool_top/--cpu, but these set the target constraints so TF's SIMD
# select()s resolve to the real arch instead of the x86_64 host.
platform(
    name = "linux_aarch64",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
)

platform(
    name = "linux_armv7",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:armv7",
    ],
)

platform(
    name = "linux_riscv64",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:riscv64",
    ],
)

# @platforms//cpu has no armv6; the generic arm constraint is enough to keep the
# target off the x86_64 SIMD path (arm1176jzf-s flags come from .bazelrc.armv6).
platform(
    name = "linux_armv6",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:arm",
    ],
)
