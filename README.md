# voivo_movie_maker

Flutter development environment using Docker and Dev Containers.

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
flutter run -d chrome --web-hostname 0.0.0.0 --web-port 8080
flutter test
```

Android SDK 36 build tools are installed for Android builds. Emulator/device forwarding depends on the host setup, so web development is the default path inside the container.
