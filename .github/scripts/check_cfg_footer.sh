#!/usr/bin/env bash
set -e

# ASCII 艺术部分
ASCII_FOOTER=$(cat <<'EOF'
echo "                                ,----, "
echo "             ,---.-,          .'   .`| "
echo "    ,---,.  '   ,'  '.     .'   .'   ; "
echo "  ,'  .' | /   /      \  ,---, '    .' "
echo ",---.'   |.   ;  ,/.  :  |   :     ./  "
echo "|   |   .''   |  | :  ;  ;   | .'  /   "
echo ":   :  :  '   |  ./   :  `---' /  ;    "
echo ":   |  |-,|   :       ,    /  ;  /     "
echo "|   :  ;/| \   \      |   ;  /  /      "
echo "|   |   .'  `---`---  ;  /  /  /       "
echo "'   :  '       |   |  |./__;  /        "
echo "|   |  |       '   :  ;|   : /         "
echo "|   :  \       |   |  ';   |/          "
echo "|   | ,'       ;   |.' `---'           "
echo "`----'         '---'                   "

echo "================================="
echo "=  F97 configuration is ready!  ="
EOF
)

# 尾部版权部分
LICENSE_PART=$(cat <<'EOF'
echo "=   SIXiaolong1117/ValveMyCFG   ="
echo "=          MIT license          ="
echo "================================="
EOF
)

# 查找所有 .cfg 文件
find . -type f -name "*.cfg" | while read -r file; do
  echo "Checking $file ..."

  # 获取最后一次修改日期
  last_date=$(git log -1 --format="%ad" --date=format:'%Y.%m.%d' -- "$file" 2>/dev/null || echo "")
  [ -z "$last_date" ] && last_date=$(date +%Y.%m.%d)

  # 检查是否包含 ASCII footer
  if grep -q "F97 configuration is ready!" "$file"; then
    # 已存在：只更新日期
    sed -i -E "s/echo \"= *[0-9]{4}\.[0-9]{2}\.[0-9]{2} *=/echo \"=           ${last_date}          =/g" "$file"
  else
    # 不存在：添加整个尾部
    {
      echo ""
      echo "$ASCII_FOOTER"
      echo "echo \"=           ${last_date}          =\""
      echo "$LICENSE_PART"
    } >> "$file"
    echo "Footer added to $file"
  fi
done
