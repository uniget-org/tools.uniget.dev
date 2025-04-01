#!/bin/bash
set -o errexit

TOOL=$1
if test -z "${TOOL}"; then
    echo "Usage: $0 <tool>"
    exit 1
fi

SIZE="$(
    regctl manifest get ghcr.io/uniget-org/tools/${TOOL}:main --platform linux/amd64 --format raw-body \
    | jq -r '.layers[].size' \
    | paste -sd+ \
    | bc
)"
if test -n "${SIZE}"; then
    SIZE_HUMAN="$(
        echo "${SIZE}" \
        | numfmt --to=iec --format=%.2f
    )"
fi

PUBLISH_DATE="$(
    git -C uniget-tools log --pretty=format:"%ad" --date=iso-strict tools/${TOOL}/manifest.yaml \
    | tail -n 1
)"

GIT_HISTORY="$(
    git -C uniget-tools log --pretty=format:'{"commit": "%h", "date": "%ad", "message": "%s"}' --date=short tools/${TOOL}/manifest.yaml \
    | head -n 10 \
    | tr '\n' ',' \
)"

cat tools/${TOOL}/manifest.json \
| jq \
    --arg tool ${TOOL} \
    --arg size ${SIZE_HUMAN} \
    --arg publish_date "${PUBLISH_DATE}" \
    --argjson git_history "[${GIT_HISTORY:0:-1}]" \
    '
        .tools[] | 
            select(.name == $tool) | 
            {
                "name":         .name,
                "version":      .version,
                "description":  .description,
                "homepage":     .homepage,
                "repository":   .repository,
                "tags":         .tags,
                "deps":         .runtime_dependencies,
                "platforms":    .platforms,
                "messages":     .messages,
                "size":         $size,
                "publish_date": $publish_date,
                "history":      $git_history,
            }
    ' \
>"tools/${TOOL}/page.json"
