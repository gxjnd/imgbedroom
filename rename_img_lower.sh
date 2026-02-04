#!/usr/bin/env bash
# 保存为 fix-case.sh，然后 chmod +x fix-case.sh
 
find . -depth -name '*[A-Z]*' -print0 | while IFS= read -r -d '' file; do
    dir=$(dirname "$file")
    base=$(basename "$file")
    lower=$(echo "$base" | tr '[:upper:]' '[:lower:]')

    if [ "$base" != "$lower" ]; then
        tmp="$dir/$base.tmp.$$"   # 加进程ID防冲突
        echo "Renaming: $file → $tmp → $dir/$lower"
        mv -vi "$file" "$tmp" || continue
        mv -vi "$tmp"   "$dir/$lower"
    fi
done