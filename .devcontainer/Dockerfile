FROM ubuntu:24.04

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
ARG FLUTTER_CHANNEL=stable
ARG ANDROID_SDK_ROOT=/opt/android-sdk
ARG ANDROID_CMDLINE_TOOLS_VERSION=11076708

ENV DEBIAN_FRONTEND=noninteractive \
    ANDROID_SDK_ROOT=${ANDROID_SDK_ROOT} \
    ANDROID_HOME=${ANDROID_SDK_ROOT} \
    FLUTTER_HOME=/opt/flutter \
    CHROME_EXECUTABLE=/usr/bin/google-chrome \
    PATH=/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools:${PATH}

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    clang \
    cmake \
    curl \
    file \
    git \
    gnupg \
    jq \
    libgtk-3-dev \
    liblzma-dev \
    libstdc++-12-dev \
    lldb \
    make \
    ninja-build \
    openjdk-17-jdk \
    pkg-config \
    sudo \
    unzip \
    wget \
    xz-utils \
    zip \
    && curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y --no-install-recommends google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*

RUN if getent group ${USER_GID} >/dev/null; then \
      EXISTING_GROUP="$(getent group ${USER_GID} | cut -d: -f1)"; \
      [ "${EXISTING_GROUP}" = "${USERNAME}" ] || groupmod -n ${USERNAME} "${EXISTING_GROUP}"; \
    else \
      groupadd --gid ${USER_GID} ${USERNAME}; \
    fi \
    && if getent passwd ${USER_UID} >/dev/null; then \
      EXISTING_USER="$(getent passwd ${USER_UID} | cut -d: -f1)"; \
      [ "${EXISTING_USER}" = "${USERNAME}" ] || usermod -l ${USERNAME} -d /home/${USERNAME} -m "${EXISTING_USER}"; \
      usermod --gid ${USER_GID} --shell /bin/bash ${USERNAME}; \
    else \
      useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -s /bin/bash; \
    fi \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

RUN git clone --depth 1 --branch ${FLUTTER_CHANNEL} https://github.com/flutter/flutter.git ${FLUTTER_HOME} \
    && mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
    && curl -fsSL -o /tmp/android-commandlinetools.zip \
      "https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_CMDLINE_TOOLS_VERSION}_latest.zip" \
    && unzip -q /tmp/android-commandlinetools.zip -d /tmp/android-cmdline-tools \
    && mv /tmp/android-cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest \
    && rm -rf /tmp/android-commandlinetools.zip /tmp/android-cmdline-tools \
    && yes | sdkmanager --licenses >/dev/null \
    && sdkmanager \
      "platform-tools" \
      "platforms;android-36" \
      "build-tools;36.0.0" \
      "cmdline-tools;latest" \
    && chown -R ${USERNAME}:${USERNAME} ${FLUTTER_HOME} ${ANDROID_SDK_ROOT}

USER ${USERNAME}
WORKDIR /workspace

RUN flutter config --android-sdk ${ANDROID_SDK_ROOT} \
    && flutter config --enable-web --enable-linux-desktop \
    && flutter precache --web --linux --android \
    && dart --disable-analytics \
    && flutter --disable-analytics
