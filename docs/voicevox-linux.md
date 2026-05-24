# VOICEVOX Linux runtime

The app uses the vendored `third_party/voicevox_flutter` wrapper and calls
VOICEVOX CORE through Dart FFI.

The current wrapper targets the legacy VOICEVOX CORE C API used by
VOICEVOX CORE `0.14.5`. Newer `0.16.x` releases use a different C API and are
not drop-in compatible with this wrapper.

Place runtime files in one of these locations:

- `voicevox/model`
- `voicevox/open_jtalk_dic_utf_8-1.11`
- `third_party/voicevox_core/linux-x64/lib/libvoicevox_core.so`
- `third_party/voicevox_core/linux-x64/lib/libonnxruntime.so.1.13.1`

You can also point to external files with environment variables:

```sh
export VOICEVOX_CORE_LIBRARY_PATH=/path/to/libvoicevox_core.so
export VOICEVOX_MODEL_DIR=/path/to/model
export VOICEVOX_OPEN_JTALK_DICT_DIR=/path/to/open_jtalk_dic_utf_8-1.11
```

The VOICEVOX CORE repository publishes built C API libraries in its releases.
The `voicevox_flutter` README expects model files from the official library
payload and an Open JTalk dictionary.
