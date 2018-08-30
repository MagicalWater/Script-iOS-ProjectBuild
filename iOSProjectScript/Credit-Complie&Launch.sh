#/bin/sh
bold=$(tput bold)
normal=$(tput sgr0)

#此腳本為編譯並且安裝到模擬器上啟動
BUILD_WORKSPACE=/Users/magicalwater/IOSProject/CPPlatform/GamePlatform/GamePlatform.xcworkspace
CONFIGURATION=Release
SCHEME=GamePlatform
DESTINATION=platform='iOS Simulator,name=iPhone 8 Plus,OS=11.2'
APP_PATH=/Users/magicalwater/IOSProject/CPPlatform/GamePlatform/build/Build/Products/${CONFIGURATION}-iphonesimulator/GamePlatform.app
APP_BUNDLE_IDENTIFIER=com.ibet.platform.GamePlatform

#編譯專案
#編譯專案後, 指定app的生成路徑, 並且安裝到模擬器上
#啟動模擬器上的app
xcodebuild -workspace ${BUILD_WORKSPACE} -scheme ${SCHEME} -configuration ${CONFIGURATION} -destination "$DESTINATION" -derivedDataPath build && \
xcrun simctl install booted ${APP_PATH} && \
xcrun simctl launch booted ${APP_BUNDLE_IDENTIFIER} && \
echo "${bold}App Launch Complete!!${normal}"
