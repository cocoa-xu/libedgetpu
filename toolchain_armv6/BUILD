# load("@bazel_tools//tools/cpp:cc_toolchains.bzl", "cc_toolchain")
# load("@bazel_tools//tools/build_defs/cc:toolchains.bzl", "cc_toolchain_suite")
load(":cc_toolchain_config.bzl", "cc_toolchain_config")

package(default_visibility = ['//visibility:public'])

cc_toolchain_suite(
    name = "gcc_cross",
    toolchains = {
        "armv6": ":armv6_toolchain",
        "k8": ":armv6_toolchain",
    },
)

filegroup(name = "empty")

cc_toolchain(
    name = "armv6_toolchain",
    toolchain_identifier = "armv6-toolchain",
    toolchain_config = ":armv6_toolchain_config",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = True,
)

cc_toolchain_config(name = "armv6_toolchain_config")
