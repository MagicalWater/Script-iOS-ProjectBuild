#/bin/sh
bold=$(tput bold)
normal=$(tput sgr0)

#準備執行編譯的workspace路徑
BET_WORKSPACE=/Users/magicalwater/IOSProject/CPSport/BetSports/BetSports.xcworkspace
#scheme
BET_SCHEME=UniveralBuilder

#平台路徑
PLATFORM_PATH=/Users/magicalwater/IOSProject/CPPlatform

#編譯運彩之前, 需要將lib移回
sh /Users/magicalwater/ProjectScript/Sport-StarcreamRemoveBak.sh

#開始編譯運彩相關
xcodebuild -workspace ${BET_WORKSPACE} -scheme ${BET_SCHEME} build

#編譯完成後(已將framework移置平台專案取代)

#因為websocket lib的關西, 需要隱藏module.
sh /Users/magicalwater/ProjectScript/Sport-StarcreamAddBak.sh

#開啟平台專案目錄
open ${PLATFORM_PATH}

echo "${bold}打包framework並轉移完成!!${normal}\n\n"
