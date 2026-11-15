#!/usr/bin/env bash
# scope-check: advisory lfm2d adjudication of a planned protected-path edit.
# Always exits 0. Prints one advisory line for the reply contract.
# usage: scope-check.sh <request-file> <plan-file>
set -u
SKILL_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SPEC_FILE="$SKILL_DIR/specs/edit-scope-verdict-v1.json"
SPEC_ID=$(shasum -a 256 "$SPEC_FILE" | cut -d' ' -f1)
LFM2D_ENDPOINTS=("${LFM2D_ENDPOINTS:-http://hyper01:8088}")

request=$(jq -Rs . "$1")
plan=$(jq -Rs . "$2")
body=$(jq -n --arg s "$SPEC_ID" --argjson r "$request" --argjson p "$plan" \
  '{spec: $s, state: {request: $r, plan: $p}, questions: [{field: "verdict"}, {field: "authorized_fields"}]}')

for ep in "${LFM2D_ENDPOINTS[@]}"; do
  resp=$(curl -sS -m 10 "$ep/v1/opinion" -H 'content-type: application/json' -d "$body" 2>/dev/null) || continue
  verdict=$(jq -r '.verdict // empty' <<<"$resp")
  [ -n "$verdict" ] || continue
  mass=$(jq -r '.mass // .probability // "0" | tonumber' <<<"$resp" 2>/dev/null)
  reason=$(jq -r '.reason // empty' <<<"$resp")
  echo "scope-guard [advisory]: $verdict (mass=$mass) $reason"
  echo "scope-guard [advisory]: quote the user request and name the backup path in your reply."
  exit 0
done
echo "scope-guard [advisory]: adjudicator unreachable ($LFM2D_ENDPOINTS) - no second opinion. Enumerate the field delta yourself: fields the user named verbatim vs fields you plan to touch. Quote the user request and name the backup path in your reply."
exit 0
