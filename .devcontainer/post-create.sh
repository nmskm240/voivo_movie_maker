#!/usr/bin/env bash
set -euo pipefail

cd /workspace

flutter doctor

flutter pub get
