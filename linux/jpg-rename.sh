local declare -a extensions=(	# 変更する拡張子
	"*.png"
	"*.PNG"
	"*.jpeg"
	"*.JPEG"
	"*.gif"
	"*.GIF"
	"*.JPG"
)

for ex in ${extensions[@]}; do
	mogrify -format jpg "${ex}"
	find . -maxdepth 1 -name "${ex}" | xargs rm
done


local IFS=$'\n'	# ファイル名の区切りを改行にする
local count=0	# 連番
local name		# ファイル名

# 入力
read -p "> Enter new file name: " name

for file in `find . -maxdepth 1 -type f -name "*.jpg"`; do
	count=$(expr $count + 1)	# インクリメント
	local fname="${name}_`printf %03d ${count}`"	# 0埋め3桁 / 連結

	mv $file "${fname}.jpg"	# ファイル名変更
done
