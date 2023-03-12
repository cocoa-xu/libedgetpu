"""
This module contains workspace definitions for building and using libedgetpu.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

# TF release 2.5.0 as of 05/17/2021.
TENSORFLOW_COMMIT = "a4dfb8d1a71385bd6d122e4f27f86dcebb96712d"
TENSORFLOW_SHA256 = "cb99f136dc5c89143669888a44bfdd134c086e1e2d9e36278c1eb0f03fe62d76"

CORAL_CROSSTOOL_COMMIT = "6bcc2261d9fc60dff386b557428d98917f0af491"
CORAL_CROSSTOOL_SHA256 = "38cb4da13009d07ebc2fed4a9d055b0f914191b344dd2d1ca5803096343958b4"

def libedgetpu_dependencies(
        tensorflow_commit = TENSORFLOW_COMMIT,
        tensorflow_sha256 = TENSORFLOW_SHA256,
        coral_crosstool_commit = CORAL_CROSSTOOL_COMMIT,
        coral_crosstool_sha256 = CORAL_CROSSTOOL_SHA256):
    """Sets up libedgetpu dependencies.

    Args:
      tensorflow_commit: https://github.com/tensorflow/tensorflow commit ID
      tensorflow_sha256: corresponding sha256 of the source archive
      coral_crosstool_commit: https://github.com/google-coral/crosstool commit ID
      coral_crosstool_sha256: corresponding sha256 of the source archive
    """
    maybe(
        http_archive,
        name = "org_tensorflow",
        urls = [
            "https://github.com/tensorflow/tensorflow/archive/" + tensorflow_commit + ".tar.gz",
        ],
        sha256 = tensorflow_sha256,
        strip_prefix = "tensorflow-" + tensorflow_commit,
    )

    maybe(
        http_archive,
        name = "coral_crosstool",
        urls = [
            "https://github.com/google-coral/crosstool/archive/" + coral_crosstool_commit + ".tar.gz",
        ],
        sha256 = coral_crosstool_sha256,
        strip_prefix = "crosstool-" + coral_crosstool_commit,
    )

    maybe(
        libusb_repository,
        name = "libusb",
    )

    # Use bazel to query values defined here, e.g.:
    #     bazel query "@libedgetpu_properties//..." | grep tensorflow_commit | cut -d\# -f2
    _properties_repository(
        name = "libedgetpu_properties",
        properties = {
            "tensorflow_commit": tensorflow_commit,
            "coral_crosstool_commit": coral_crosstool_commit,
        },
    )

def _libusb_impl(ctx):
    path = "/workspace/libusb"
    build_file_content = """
cc_library(
  name = "headers",
  srcs = ["root/lib/libusb-1.0.a"],
  visibility = ["//visibility:public"],
  includes = ["root/include"],
  hdrs = ["root/include/libusb-1.0/libusb.h"],
)
"""
    ctx.symlink(path, "root")
    ctx.file(
        "BUILD",
        content = build_file_content,
        executable = False,
    )

libusb_repository = repository_rule(
    implementation = _libusb_impl,
)

def _properties_impl(ctx):
    content = ""
    for name, value in ctx.attr.properties.items():
        content += "filegroup(name='" + name + "#" + value + "')\n"
    ctx.file("BUILD", content = content, executable = False)

_properties_repository = repository_rule(
    implementation = _properties_impl,
    attrs = {
        "properties": attr.string_dict(),
    },
)
