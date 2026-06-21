#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <voicevox-resource-directory>" >&2
  exit 64
fi

core_version="${VOICEVOX_CORE_VERSION:-0.16.4}"
onnxruntime_version="${VOICEVOX_ONNXRUNTIME_VERSION:-1.17.3}"
resource_source="$(realpath "$1")"
temporary_directory="$(mktemp -d)"
trap 'rm -rf "$temporary_directory"' EXIT

find_one() {
  local root="$1"
  local name="$2"
  local result
  result="$(find "$root" -name "$name" -print -quit)"
  if [[ -z "$result" ]]; then
    echo "Required VOICEVOX runtime item was not found: $name" >&2
    exit 66
  fi
  printf '%s\n' "$result"
}

download() {
  local url="$1"
  local output="$2"
  echo "Downloading $(basename "$output")"
  curl --fail --location --retry 3 "$url" --output "$output"
}

core_release="https://github.com/VOICEVOX/voicevox_core/releases/download/$core_version"
onnx_release="https://github.com/VOICEVOX/onnxruntime-builder/releases/download/voicevox_onnxruntime-$onnxruntime_version"

download \
  "$core_release/voicevox_core-android-arm64-$core_version.zip" \
  "$temporary_directory/core-android.zip"
download \
  "$core_release/voicevox_core-ios-xcframework-cpu-$core_version.zip" \
  "$temporary_directory/core-ios.zip"
download \
  "$onnx_release/voicevox_onnxruntime-android-arm64-$onnxruntime_version.tgz" \
  "$temporary_directory/onnxruntime-android.tgz"
download \
  "$onnx_release/voicevox_onnxruntime-ios-xcframework-$onnxruntime_version.zip" \
  "$temporary_directory/onnxruntime-ios.zip"

mkdir -p "$temporary_directory/core-android" "$temporary_directory/core-ios"
mkdir -p "$temporary_directory/onnxruntime-android" "$temporary_directory/onnxruntime-ios"
unzip -q "$temporary_directory/core-android.zip" -d "$temporary_directory/core-android"
unzip -q "$temporary_directory/core-ios.zip" -d "$temporary_directory/core-ios"
tar -xzf "$temporary_directory/onnxruntime-android.tgz" -C "$temporary_directory/onnxruntime-android"
unzip -q "$temporary_directory/onnxruntime-ios.zip" -d "$temporary_directory/onnxruntime-ios"

core_so="$(find_one "$temporary_directory/core-android" libvoicevox_core.so)"
onnx_so="$(find_one "$temporary_directory/onnxruntime-android" libvoicevox_onnxruntime.so)"
core_xcframework="$(find_one "$temporary_directory/core-ios" voicevox_core.xcframework)"
onnx_xcframework="$(find_one "$temporary_directory/onnxruntime-ios" voicevox_onnxruntime.xcframework)"
dict_directory="$(find_one "$resource_source" open_jtalk_dic_utf_8-1.11)"
models_directory="$(find_one "$resource_source" models)"

rm -rf android/app/src/main/jniLibs/arm64-v8a
mkdir -p android/app/src/main/jniLibs/arm64-v8a
cp "$core_so" "$onnx_so" android/app/src/main/jniLibs/arm64-v8a/

rm -rf ios/Frameworks/voicevox_core.xcframework ios/Frameworks/voicevox_onnxruntime.xcframework
mkdir -p ios/Frameworks
cp -a "$core_xcframework" "$onnx_xcframework" ios/Frameworks/

rm -rf assets/voicevox/dict assets/voicevox/models
mkdir -p assets/voicevox/dict assets/voicevox/models
cp -a "$dict_directory"/. assets/voicevox/dict/
find "$models_directory" -type f -name '*.vvm' -exec cp '{}' assets/voicevox/models/ \;
touch assets/voicevox/dict/.gitkeep assets/voicevox/models/.gitkeep

echo "Installed VOICEVOX Core $core_version for Android and iOS."
