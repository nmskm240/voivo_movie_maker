# Embedded VOICEVOX Core for Android and iOS

The app calls VOICEVOX Core directly through Dart FFI. It does not start a
VOICEVOX Engine process and does not require a network connection.

## Runtime layout

First use the official VOICEVOX Core downloader to prepare a resource directory
containing the dictionary and the VVM files. Then install the mobile runtimes:

```sh
# After downloading the official downloader:
./download --only models dict --models-pattern 0.vvm -o voicevox_resources

./tool/install_voicevox_mobile.sh /path/to/downloaded_voicevox_resources
```

The resource directory must contain:

- Resources: `dict/open_jtalk_dic_utf_8-1.11/*` and one or more VVM files below
  `models/`

The script downloads the official Android arm64 and iOS XCFramework releases,
copies the native libraries into the platform projects, and copies the
dictionary and voice models into Flutter assets. Set `VOICEVOX_CORE_VERSION` or
`VOICEVOX_ONNXRUNTIME_VERSION` to override the pinned versions when upgrading.
These payloads are ignored by Git because they are large and have their own
distribution terms.

After installing the files, build normally:

```sh
flutter run -d <android-device>
flutter build ios
```

An iOS build requires macOS and Xcode. Run `pod install` in `ios/` before the
first iOS build.

To verify Core initialization and synthesis on a connected mobile device:

```sh
flutter test integration_test/voice_generator_test.dart -d <device-id>
```

## Distribution

VOICEVOX Core, ONNX Runtime, and each VVM voice model have separate licenses and
terms. Generated content generally requires a VOICEVOX credit. Check the current
official terms and each character's terms before distributing the app or audio.
