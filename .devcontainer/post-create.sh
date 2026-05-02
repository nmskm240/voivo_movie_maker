#!/usr/bin/env bash
set -euo pipefail

cd /workspace

flutter doctor

if [ ! -f pubspec.yaml ]; then
  flutter create --platforms=android,web,linux --project-name voivo_movie_maker .
fi

flutter pub get
