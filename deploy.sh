#!/usr/bin/env bash
if [[ "$TRAVIS_OS_NAME" == "osx" ]]
then
  cd ios && fastlane release
elif [[ "$TRAVIS_OS_NAME" == "linux" ]]
then
      cd android && fastlane supply init
      fastlane deploy
fi
