#因應運彩專案的STARSCREAM(WebSocket)中檔案會在運彩與平台相衝, 並且將運彩中相沖的檔案重新命成加入.bak的後續
#因運彩相衝而重新命名的檔案轉回, 以便運彩專案能順利執行

#需要改名的lib
STARSCREAM_LIB=/Users/magicalwater/IOSProject/CPSport/BetSports/Pods/Starscream/zlib/module.modulemap

#改名加入.bak
STARSCREAM_BAK_LIB=${STARSCREAM_LIB}.bak

mv ${STARSCREAM_BAK_LIB} ${STARSCREAM_LIB}