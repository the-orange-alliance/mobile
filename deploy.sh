#!/usr/bin/env bash
openssl aes-256-cbc -K $encrypted_29727b427600_key -iv $encrypted_29727b427600_iv -in credentials.tar.xz.enc -out credentials.tar.xz -d
tar -xf credentials.tar.xz
mv android-keystore.jks android/app
mv key.properties android
mv google-services.json android/app
mv GoogleService-Info.plist ios/Runner
mv api-9048300026487180911-124804-e70b22003165.json android
if [[ "$TRAVIS_OS_NAME" == "osx" ]]
then
  cd ios && fastlane release # If OS is Mac
elif [[ "$TRAVIS_OS_NAME" == "linux" ]]
then
      cd android && fastlane supply init
      fastlane deploy
fi
