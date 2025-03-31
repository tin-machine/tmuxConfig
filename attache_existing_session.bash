#!/bin/bash

# tmuxのセッションが既にアタッチされているかを確認し、アタッチされていないセッションがあればアタッチする
attach_to_existing_session() {
    # tmuxのセッションリストを取得し、アタッチされていないセッションがあるかを確認
    local session=$(tmux list-sessions | grep -v attached | head -n 1 | cut -d: -f1)
    if [ -n "$session" ]; then
        tmux attach -t "$session"  # アタッチされていないセッションにアタッチ
    else
        tmux new-session  # デフォルトの設定で新しいtmuxセッションを起動
    fi
}

attach_to_existing_session  # 関数を呼び出して実行
