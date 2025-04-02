#!/usr/bin/env bash
# shortpath.sh
# 現在の作業ディレクトリを短縮表示するスクリプトです。
# ディレクトリの階層が4以上の場合、上位部分を "..." に置き換えて下位2階層のみ表示します。

if [ -n "$1" ]; then
    current_path="$1"
else
    current_path=$(pwd)
fi

awk -F/ '{
    if (NF > 4)
        printf(".../%s/%s", $(NF-1), $NF);
    else
        print $0
}' <<< "$current_path"

