#!/bin/bash
# Memory Nexus SessionStart hook — mechanical briefing injection.
# Calls the session_start API and injects briefing as additionalContext.

API_KEY="${MEMORY_NEXUS_API_KEY:-}"
BASE_URL="${MEMORY_NEXUS_BASE_URL:-https://api.memory-nexus.org}"

if [ -z "$API_KEY" ]; then
  # No API key — skip silently
  echo '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":""}}'
  exit 0
fi

# Detect project from git
PROJECT_HASH=""
REMOTE=$(git remote get-url origin 2>/dev/null)
if [ -n "$REMOTE" ]; then
  PROJECT_HASH=$(echo -n "$REMOTE" | shasum -a 256 | head -c 12)
fi

# Call session_start API
RESPONSE=$(curl -s --max-time 4 \
  -H "X-API-Key: $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{\"project_hash\":\"$PROJECT_HASH\",\"task_context\":\"\"}" \
  "$BASE_URL/v1/session/start" 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$RESPONSE" ]; then
  # API unreachable — skip silently
  echo '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":""}}'
  exit 0
fi

# Extract rendered briefing text
BRIEFING=$(echo "$RESPONSE" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    parts = []
    briefing = data.get('briefing', {})
    rendered = briefing.get('rendered_text', '')
    if rendered:
        parts.append(rendered)
    empire = data.get('empire', {})
    prefs = empire.get('preferences', [])
    if prefs:
        parts.append('\nEMPIRE PREFERENCES')
        for p in prefs:
            parts.append(f\"- {p.get('content', '')}\")
    handoff = data.get('handoff', {})
    summary = handoff.get('summary', '')
    if summary:
        parts.append(f'\nLAST SESSION: {summary}')
    next_steps = handoff.get('next_steps', [])
    if next_steps:
        parts.append('NEXT STEPS')
        for s in next_steps:
            parts.append(f\"- {s if isinstance(s, str) else s.get('content', '')}\")
    print(json.dumps('\n'.join(parts)))
except Exception:
    print('\"\"')
" 2>/dev/null)

# Inject as additionalContext
echo "{\"hookSpecificOutput\":{\"hookEventName\":\"SessionStart\",\"additionalContext\":$BRIEFING}}"
