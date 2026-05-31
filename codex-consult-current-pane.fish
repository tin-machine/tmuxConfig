#!/usr/bin/env fish

set -l source_pane $argv[1]
set -l source_window $argv[2]
set -l source_path $argv[3]

if test -z "$source_pane" -o -z "$source_window"
    printf "%s\n" "usage: codex-consult-current-pane.fish <pane_id> <window_id> <cwd>" >&2
    exit 2
end

if test -z "$source_path" -o ! -d "$source_path"
    set source_path (tmux display-message -p -t "$source_pane" '#{pane_current_path}' 2>/dev/null)
end

if test -z "$source_path" -o ! -d "$source_path"
    set source_path $HOME
end

set -l codex_path (command -v codex 2>/dev/null)
for candidate in /opt/volta/bin/codex ~/.volta/bin/codex /opt/homebrew/bin/codex /usr/local/bin/codex
    if test -z "$codex_path" -a -x "$candidate"
        set codex_path $candidate
    end
end

if test -z "$codex_path"
    tmux display-message "codex-consult: codex command not found"
    exit 1
end

set -l prompt '
あなたは tmux の同じ window を見ながら相談に乗る補助エージェントです。

ユーザーは別 pane で作業中です。
対象 pane は環境変数 CODEX_TMUX_SOURCE_PANE に入っています。
対象 window は環境変数 CODEX_TMUX_SOURCE_WINDOW に入っています。

ユーザーから相談や質問を受けたら、回答の前に毎回まず次を実行して現在表示中の画面だけを取得してください。

tmux capture-pane -p -e -S - -t "$CODEX_TMUX_SOURCE_PANE"

過去の scrollback を広く読む必要はありません。
まず見えている画面に基づいて相談に乗ってください。
nvim の plugin、設定、shortcut、エラー、候補調査について、必要なら read-only なコマンドで追加調査してください。
ユーザーの明示的な依頼なしにファイル編集や git 操作はしないでください。
'

set -l command env \
    CODEX_TMUX_SOURCE_PANE=$source_pane \
    CODEX_TMUX_SOURCE_WINDOW=$source_window \
    CODEX_TMUX_SOURCE_PATH=$source_path \
    "$codex_path" --cd "$source_path" "$prompt"

set -l escaped_command (string escape --style=script -- $command)
tmux split-window -v -t "$source_pane" -c "$source_path" -- (string join ' ' -- $escaped_command)
