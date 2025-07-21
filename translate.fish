#!/usr/bin/env fish

set text (cat)
set result (curl -s "https://api-free.deepl.com/v2/translate" \
  -d auth_key="$DEEPL_API_KEY" \
  --data-urlencode text="$text" \
  -d target_lang=JA \
  | jq -r '.translations[0].text' | tee -a ~/log.txt )
/opt/tmux/bin/tmux display-popup -E "echo $result | less -R +1"
