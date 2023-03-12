load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "tool_path",
)

# all_link_actions = [
#     ACTION_NAMES.cpp_link_executable,
#     ACTION_NAMES.cpp_link_dynamic_library,
#     ACTION_NAMES.cpp_link_nodeps_dynamic_library,
# ]

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "gcc",
            path = "/usr/bin/arm-linux-gnueabihf-gcc",
        ),
        tool_path(
            name = "g++",
            path = "/usr/bin/arm-linux-gnueabihf-g++",
        ),
        tool_path(
            name = "ld",
            path = "/usr/bin/arm-linux-gnueabihf-ld",
        ),
        tool_path(
            name = "ar",
            path = "/usr/bin/arm-linux-gnueabihf-ar",
        ),
        tool_path(
            name = "cpp",
            path = "/usr/bin/arm-linux-gnueabihf-cpp",
        ),
        tool_path(
            name = "gcov",
            path = "/usr/bin/arm-linux-gnueabihf-gcov",
        ),
        tool_path(
            name = "nm",
            path = "/usr/bin/arm-linux-gnueabihf-nm",
        ),
        tool_path(
            name = "objdump",
            path = "/usr/bin/arm-linux-gnueabihf-objdump",
        ),
        tool_path(
            name = "strip",
            path = "/usr/bin/arm-linux-gnueabihf-strip",
        ),
    ]

    supports_pic_feature = feature(name = "supports_pic", enabled = True)
    supports_dynamic_linker_feature = feature(name = "supports_dynamic_linker", enabled = True)
    features = [supports_dynamic_linker_feature, supports_pic_feature]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        cxx_builtin_include_directories = [
            "/usr/lib/gcc-cross/arm-linux-gnueabihf/8/include",
            "/usr/arm-linux-gnueabihf/include/c++/8",
            "/usr/lib/gcc-cross/arm-linux-gnueabihf/8/include-fixed",
            "/usr/arm-linux-gnueabihf/include",
            "/workspace/libusb/include/",
        ],
        toolchain_identifier = "armv6-toolchain",
        host_system_name = "linux",
        target_system_name = "linux",
        target_cpu = "armv6",
        target_libc = "unknown",
        compiler = "gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
