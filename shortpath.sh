#!/usr/bin/env bash
# shortpath.sh
# 現在の作業ディレクトリを短縮表示するスクリプトです。
# ディレクトリの階層が4以上の場合、上位部分を "..." に置き換えて下位2階層のみ表示します。

current_path=$(pwd)
awk -F/ '{
  if (NF > 3)
    printf(".../%s/%s", $(NF-1), $NF);
  else
    print $0
}' <<< "$current_path"

