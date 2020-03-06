FROM ubuntu:18.04

ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_COMPILE_SDK 29
ENV ANDROID_BUILD_TOOLS 29.0.3

RUN apt-get update
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y wget unzip
RUN wget https://services.gradle.org/distributions/gradle-5.6.4-bin.zip
RUN unzip gradle-5.6.4-bin.zip
RUN mv gradle-5.6.4 /opt/gradle
RUN chmod a+x /opt/gradle/bin/gradle
RUN ln -s /opt/gradle/bin/gradle /bin/gradle

RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip
RUN unzip -d android-sdk commandlinetools-linux-6200805_latest.zip
RUN mv android-sdk /opt/android-sdk
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager --sdk_root=$ANDROID_HOME "tools"
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-$ANDROID_COMPILE_SDK"
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "platform-tools"
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
RUN yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses
