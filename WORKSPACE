# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
workspace(name = "libedgetpu")

load(":workspace.bzl", "libedgetpu_dependencies")
libedgetpu_dependencies()

load("@org_tensorflow//tensorflow:workspace3.bzl", "tf_workspace3")
tf_workspace3()

load("@org_tensorflow//tensorflow:workspace2.bzl", "tf_workspace2")
tf_workspace2()

load("@org_tensorflow//tensorflow:workspace1.bzl", "tf_workspace1")
tf_workspace1()

load("@org_tensorflow//tensorflow:workspace0.bzl", "tf_workspace0")
tf_workspace0()

load("@coral_crosstool//:configure.bzl", "cc_crosstool")
cc_crosstool(name = "crosstool", cpp_version = "c++14")

CPU_TYPE = "$(env.CPU)"

BAZEL_ZIG_CC_VERSION = "1.0.4-armv6" if CPU_TYPE == "armv6" else "1.0.3"
BAZEL_ZIG_CC_SHA256 = "868883534c442a73f17016d24f7da709fde3ce6b0b12838c9898e3789cacbc33" if CPU_TYPE == "armv6" else "b1a20a76f75ad0585d12ca1260b3a9df1da0f19d1d602f59ecba040aeb3c6a27"
BAZEL_ZIG_TOOCHAIN_VERSION = "0.9.1" if CPU_TYPE == "armv6" else "0.10.1"
BAZEL_ZIG_TOOCHAIN_LINUX_K8 = "be8da632c1d3273f766b69244d80669fe4f5e27798654681d77c992f17c237d7" if CPU_TYPE == "armv6" else "6699f0e7293081b42428f32c9d9c983854094bd15fee5489f12c4cf4518cc380"
BAZEL_ZIG_TOOCHAIN_LINUX_ARM64 = "5d99a39cded1870a3fa95d4de4ce68ac2610cca440336cfd252ffdddc2b90e66" if CPU_TYPE == "armv6" else "db0761664f5f22aa5bbd7442a1617dd696c076d5717ddefcc9d8b95278f71f5d"
BAZEL_ZIG_TOOCHAIN_MACOS_K8 = "2d94984972d67292b55c1eb1c00de46580e9916575d083003546e9a01166754c" if CPU_TYPE == "armv6" else "02483550b89d2a3070c2ed003357fd6e6a3059707b8ee3fbc0c67f83ca898437"
BAZEL_ZIG_TOOCHAIN_MACOS_ARM64 = "8c473082b4f0f819f1da05de2dbd0c1e891dff7d85d2c12b6ee876887d438287" if CPU_TYPE == "armv6" else "b9b00477ec5fa1f1b89f35a7d2a58688e019910ab80a65eac2a7417162737656"

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive") 
http_archive(
    name = "bazel-zig-cc",
    sha256 = BAZEL_ZIG_CC_SHA256,
    strip_prefix = "bazel-zig-cc-{}".format(BAZEL_ZIG_CC_VERSION),
    urls = ["https://github.com/cocoa-xu/bazel-zig-cc/archive/refs/tags/v{}.tar.gz".format(BAZEL_ZIG_CC_VERSION)],
)

load("@bazel-zig-cc//toolchain:defs.bzl", zig_toolchains = "toolchains")
zig_toolchains(
    version = BAZEL_ZIG_TOOCHAIN_VERSION,
    url_formats = [
        "https://ziglang.org/download/{version}/zig-{host_platform}-{version}.tar.xz",
    ],
    host_platform_sha256 = {
        "linux-x86_64": BAZEL_ZIG_TOOCHAIN_LINUX_K8,
        "linux-aarch64": BAZEL_ZIG_TOOCHAIN_LINUX_ARM64,
        "macos-x86_64": BAZEL_ZIG_TOOCHAIN_MACOS_K8,
        "macos-aarch64": BAZEL_ZIG_TOOCHAIN_MACOS_ARM64
    },
)
