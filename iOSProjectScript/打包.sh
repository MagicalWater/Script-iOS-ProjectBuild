#/bin/sh
bold=$(tput bold)
normal=$(tput sgr0)

CONFIGURATION=Release

#真機默認 sdk 11.2, 具體使用根據當前mac sdk改變, 若有不同的地方使用下列命令查看
#xcodebuild -showsdks
SDK_DEVICE='iphoneos11.2'

#模擬器默認 iphone 8 plus
DESTINATION_SIMULATOR='platform=iOS Simulator,name=iPhone 8 Plus,OS=11.2'

#若是模擬器, 生成文件默認在專案資料夾下的build
BUILD_APP_DIR_NAME=build

#最後發佈的檔案路徑
ARCHIVE_EXPORT_PATH=/Users/magicalwater/ArchiveExportPlist

#發布的暫存路徑
ARCHIVE_TMP_PATH=/Users/magicalwater/ArchiveTmp

#現金版設定
CASH_PROJECT_PATH=/Users/magicalwater/IOSProject/CPPlatform/GamePlatformCash
CASH_WORKSPACE=GamePlatformCash.xcworkspace

#皇璽會-正式
CASH_RELEASE_SCHEME=GamePlatformCash
CASH_RELEASE_BUNDLE_ID=com.ibet.platform.GamePlatformCash
CASH_RELEASE_OPTION_LIST=/Users/magicalwater/ArchiveExportPlist/${CASH_RELEASE_SCHEME}/ExportOptions.plist

#皇璽會-測試
CASH_DEBUG_SCHEME=GamePlatformCashDebug
CASH_DEBUG_BUNDLE_ID=com.ibet.platformDebug.GamePlatformCash
CASH_DEBUG_OPTION_LIST=/Users/magicalwater/ArchiveExportPlist/${CASH_DEBUG_SCHEME}/ExportOptions.plist

#皇璽會-體驗站
CASH_EXP_SCHEME=GamePlatformExp
CASH_EXP_BUNDLE_ID=com.ibet.platform.GamePlatformCashExp
CASH_EXP_OPTION_LIST=/Users/magicalwater/ArchiveExportPlist/${CASH_EXP_SCHEME}/ExportOptions.plist


#信用版設定
CREDIT_PROJECT_PATH=/Users/magicalwater/IOSProject/CPPlatform/GamePlatform
CREDIT_WORKSPACE=GamePlatform.xcworkspace

#皇璽會-正式
CREDIT_RELEASE_SCHEME=GamePlatform
CREDIT_RELEASE_BUNDLE_ID=com.ibet.platform.GamePlatform
CREDIT_RELEASE_OPTION_LIST=/Users/magicalwater/ArchiveExportPlist/${CREDIT_RELEASE_SCHEME}/ExportOptions.plist

#皇璽會-測試
CREDIT_DEBUG_SCHEME=GamePlatformDebug
CREDIT_DEBUG_BUNDLE_ID=com.ibet.platformDebug.GamePlatform
CREDIT_DEBUG_OPTION_LIST=/Users/magicalwater/ArchiveExportPlist/${CREDIT_DEBUG_BUNDLE_ID}/ExportOptions.plist


#先創建暫存資料夾
mkdir -p $ARCHIVE_TMP_PATH

#帶入數字, 返回對應的站台名稱
function mapPlatofrmName()
{
	if [ "$1" == "1" ]; then
		echo "皇璽會 - 正式"
	elif [ "$1" == "2" ]; then
		echo "皇璽會 - 測試"
	elif [ "$1" == "3" ]; then
		echo "皇璽會 - 體驗"
	elif [ "$1" == "4" ]; then
		echo "法老王 - 正式"
	elif [ "$1" == "5" ]; then
		echo "法老王 - 測試"
	else
		echo "不存在的選項 $1 終止運行"
		exit 1
	fi
}

#declare -i nn=1
echo "~~~~~~~~~~~~選擇打包平台(輸入序號)~~~~~~~~~~~~~~~"
echo "  1 $(mapPlatofrmName 1)"
echo "  2 $(mapPlatofrmName 2)"
echo "  3 $(mapPlatofrmName 3)"
echo "  4 $(mapPlatofrmName 4)"
echo "  5 $(mapPlatofrmName 5)"
echo "  0 開始打包"

# 讀取輸入
read parameter
sleep 0.2
method="$parameter"

archive_target=()
archive_result=()

while [ -n "$method" ] && [ "$method" != "0" ]; do
	isExit="0"

	#判斷選擇是否已經存在
	for i in "${archive_target[@]}"; do
		[ "$i" == "$method" ] && [ "$isExit" == "0" ] && isExit = "1"
	done

	if [ "$isExit" != "1" ]; then
		archive_target+=("$method")
	fi

	read parameter
	sleep 0.2

	method="$parameter"
done

for i in "${archive_target[@]}"; do
	echo "選擇 $(mapPlatofrmName $i)"
	sleep 1
done

for i in "${archive_target[@]}"; do
	echo "開始打包 $(mapPlatofrmName $i)"
	if [ "$i" == "1" ]; then
		#echo "開始打包 $(mapPlatofrmName $i)"
		WROK_SPACE=$CASH_WORKSPACE
		PROJECT_PATH=$CASH_PROJECT_PATH
		SCHEME=$CASH_RELEASE_SCHEME
		BUINDLE_ID=$CASH_RELEASE_BUNDLE_ID
		OPTION_LIST=$CASH_RELEASE_OPTION_LIST
	elif [ "$i" == "2" ]; then
		#echo "開始打包 皇璽會 - 測試"
		WROK_SPACE=$CASH_WORKSPACE
		PROJECT_PATH=$CASH_PROJECT_PATH
		SCHEME=$CASH_DEBUG_SCHEME
		BUINDLE_ID=$CASH_DEBUG_BUNDLE_ID
		OPTION_LIST=$CASH_DEBUG_OPTION_LIST
	elif [ "$i" == "3" ]; then
		#echo "開始打包 皇璽會 - 體驗"
		WROK_SPACE=$CASH_WORKSPACE
		PROJECT_PATH=$CASH_PROJECT_PATH
		SCHEME=$CASH_EXP_SCHEME
		BUINDLE_ID=$CASH_EXP_BUNDLE_ID
		OPTION_LIST=$CASH_EXP_OPTION_LIST
	elif [ "$i" == "4" ]; then
		#echo "開始打包 法老王 - 正式"
		WROK_SPACE=$CREDIT_WORKSPACE
		PROJECT_PATH=$CREDIT_PROJECT_PATH
		SCHEME=$CREDIT_RELEASE_SCHEME
		BUINDLE_ID=$CREDIT_RELEASE_BUNDLE_ID
		OPTION_LIST=$CREDIT_RELEASE_OPTION_LIST
	elif [ "$i" == "5" ]; then
		#echo "開始打包 法老王 - 測試"
		WROK_SPACE=$CREDIT_WORKSPACE
		PROJECT_PATH=$CREDIT_PROJECT_PATH
		SCHEME=$CREDIT_DEBUG_SCHEME
		BUINDLE_ID=$CREDIT_DEBUG_BUNDLE_ID
		OPTION_LIST=$CREDIT_DEBUG_OPTION_LIST
	fi

	# 接著按照先後執行下列動作
	# 1. 編譯專案
	# 2. archive 到 tmp
	# 3. export 到 tmp
	xcodebuild -workspace "${PROJECT_PATH}/${WROK_SPACE}" -scheme ${SCHEME} -configuration ${CONFIGURATION} -sdk "$SDK_DEVICE" -derivedDataPath deviceBuild && \
	xcodebuild archive -workspace "${PROJECT_PATH}/${WROK_SPACE}" -scheme ${SCHEME} -configuration ${CONFIGURATION} -archivePath "${ARCHIVE_TMP_PATH}/${SCHEME}.xcarchive" && \
	xcodebuild -exportArchive -archivePath "${ARCHIVE_TMP_PATH}/${SCHEME}.xcarchive" -exportOptionsPlist ${OPTION_LIST} -exportPath "${ARCHIVE_TMP_PATH}"

	#判斷上面的步驟是否成功, 若是成功則將檔案移動到真正存放export的地方
	if [ $? -eq 0 ]; then
		#指令成功, 將tmp底下檔案移動到正式export的地方
		dateName=`date +"%Y-%m-%d %H-%M-%S"`
		mv "${ARCHIVE_TMP_PATH}/" "${ARCHIVE_EXPORT_PATH}/${SCHEME}/${dateName}/"
		echo "打包完成 $(mapPlatofrmName $i)"
		archive_result+="$(mapPlatofrmName $i) 完成"
	else
		archive_result+="$(mapPlatofrmName $i) 失敗"
	fi

	#無論指令是否成功, 刪除tmp底下所有檔案
	rm -r "${ARCHIVE_TMP_PATH}"

	#重新創建 tmp dir
	mkdir -p $ARCHIVE_TMP_PATH

done

echo "\n\n"
echo "${bold}打包全部完成, 結果:"
for i in "${archive_result[@]}"; do
	echo "    ${i}\n"
done
echo "\n\n${normal}"

