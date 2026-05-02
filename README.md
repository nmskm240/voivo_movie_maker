# voivo_movie_maker

Flutter development environment for mobile and desktop targets using Docker and Dev Containers.

## Requirements

- Docker
- VS Code
- Dev Containers extension

## Start

1. Open this folder in VS Code.
2. Run `Dev Containers: Reopen in Container`.
3. Wait for the container build and `postCreateCommand` to finish.

If `pubspec.yaml` does not exist, the container creates a Flutter project in this directory.

## Common Commands

```bash
flutter doctor
flutter pub get
flutter run -d linux
flutter build linux --debug
flutter test
```

Android SDK 36 build tools are installed for Android builds. Web is intentionally disabled because video export uses native FFmpegKit.

## Linux Desktop Debugging

The Dev Container is configured to pass the NVIDIA GPU and host X11 socket into the container. This allows `flutter run -d linux` to open a normal host desktop window while still supporting VS Code breakpoints and hot reload.

Before reopening the container, make sure Docker is using the local Engine context and X11 local clients are allowed:

```bash
docker context use default
xhost +local:
```

NVIDIA Container Toolkit must also be working:

```bash
docker run --rm --gpus all nvidia/cuda:13.0.0-base-ubuntu24.04 nvidia-smi
```

Then rebuild or reopen the Dev Container and run from VS Code:

```bash
flutter run -d linux
```

The app window should appear as a normal desktop window on the host, and VS Code debugging should work normally.
