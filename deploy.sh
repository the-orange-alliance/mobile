#!/usr/bin/env bash
echo "Running on $TRAVIS_OS_NAME"

if [[ "$TRAVIS_OS_NAME" == "osx" ]]
then
  cd ios && fastlane release
elif [[ "$TRAVIS_OS_NAME" == "linux" ]]
then
      # export SUPPLY_VERSION_CODE=211
      cd android && fastlane supply init
      fastlane deploy
fi
