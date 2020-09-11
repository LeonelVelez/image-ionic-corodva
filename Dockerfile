FROM ubuntu:xenial

ARG NODEJS_VERSION="12"
ARG IONIC_VERSION="5.4.16"
ARG ANDROID_SDK_VERSION="3859397"
ARG ANDROID_HOME="/opt/android-sdk"
ARG ANDROID_BUILD_TOOLS_VERSION="26.0.2"
USER root
ENV ANDROID_HOME "${ANDROID_HOME}"

RUN apt-get update \
    && apt-get install -y \
       build-essential \
       openjdk-8-jre \
       openjdk-8-jdk \
       curl \
       unzip \
       git \
       gradle \
    && curl -sL https://deb.nodesource.com/setup_${NODEJS_VERSION}.x | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && npm install -g cordova ionic@${IONIC_VERSION} \
    && npm install --unsafe-perm -g cordova-res  \	
    && cd /tmp \
    && curl -fSLk https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip -o sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
    && unzip sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \
    && mkdir /opt/android-sdk \
    && mv tools /opt/android-sdk \
    && (while sleep 3; do echo "y"; done) | $ANDROID_HOME/tools/bin/sdkmanager --licenses \
    && $ANDROID_HOME/tools/bin/sdkmanager "platform-tools" \
    && $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    && apt-get autoremove -y \
    && rm -rf /tmp/sdk-tools-linux-${ANDROID_SDK_VERSION}.zip \ 
    && mkdir /ionicapp

WORKDIR /ionicapp



    
