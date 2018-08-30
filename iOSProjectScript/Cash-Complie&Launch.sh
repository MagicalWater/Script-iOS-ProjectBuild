#/bin/sh
bold=$(tput bold)
normal=$(tput sgr0)

#此腳本為編譯並且安裝到模擬器上啟動
PROJECT_PATH=/Users/magicalwater/IOSProject/CPPlatform/GamePlatformCash
BUILD_WORKSPACE=${PROJECT_PATH}/GamePlatformCash.xcworkspace
CONFIGURATION=Release
SCHEME=GamePlatformCash
DESTINATION='platform=iOS Simulator,name=iPhone 8 Plus,OS=11.2'
APP_PATH=${PROJECT_PATH}/build/Build/Products/${CONFIGURATION}-iphonesimulator/${SCHEME}.app
APP_BUNDLE_IDENTIFIER=com.ibet.platform.GamePlatformCash

#編譯專案
#編譯專案後, 指定app的生成路徑, 並且安裝到模擬器上
#啟動模擬器上的app
xcodebuild -workspace ${BUILD_WORKSPACE} -scheme ${SCHEME} -configuration ${CONFIGURATION} -destination "$DESTINATION" -derivedDataPath build
#xcrun simctl install booted ${BUILD_WORKSPACE} && \
#xcrun simctl launch booted ${APP_BUNDLE_IDENTIFIER} && \
echo "${bold}App Launch Complete!!${normal}"

#xcodebuild archive -workspace ${BUILD_WORKSPACE} -scheme ${SCHEME} -configuration ${CONFIGURATION} -archivePath "/Users/magicalwater/Desktop/1.xcarchive"

echo "打包完成, 開始輸出ipa"

# export
# xcodebuild -exportArchive -archivePath /Users/magicalwater/Desktop/1.xcarchive -exportOptionsPlist /Users/magicalwater/ProjectScript/Cash-ExportOptions.plist -exportPath "/Users/magicalwater/Desktop/export"

echo "輸出ipa完成\n\n"

open "/Users/magicalwater/Desktop/"
