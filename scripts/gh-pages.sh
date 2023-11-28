#!/bin/bash
set -o errexit

tool=$1
if test -z "${tool}"; then
    echo "Usage: $0 <tool>"
    exit 1
fi

if ! test -f metadata.json; then
    echo "ERROR: Missing metadata.json."
    exit 1
fi

TOOL_JSON="$(jq --arg name "${tool}" '.tools[] | select(.name == $name)' metadata.json)"

version="$(jq --raw-output '.version' <<<"${TOOL_JSON}")"
tags="$(jq --raw-output --compact-output '.tags' <<<"${TOOL_JSON}")"
description="$(jq --raw-output '.description' <<<"${TOOL_JSON}" | sed s/\"/\'/g)"
homepage="$(jq --raw-output '.homepage' <<<"${TOOL_JSON}" | sed s/\"/\'/g)"
build_deps="$(jq --raw-output 'select(.build_dependencies != null) | .build_dependencies[]' <<<"${TOOL_JSON}")"
runtime_deps="$(jq --raw-output 'select(.runtime_dependencies != null) | .runtime_dependencies[]' <<<"${TOOL_JSON}")"
   
cat <<EOF
---
title: "${tool} ${version}"
tags: ${tags}
summary: "${description}"
---

## Description

${description}

## Homepage

${homepage}

## Install

\`uniget install ${tool}\`

## Dependencies

EOF

if test -n "${build_deps}" || test -n "${runtime_deps}"; then
    for DEP in ${build_deps}; do
        echo "- Build: [${DEP}](/tools/${DEP}/) "
    done
    for DEP in ${runtime_deps}; do
        echo "- Runtime: [${DEP}](/tools/${DEP}/) "
    done
else
    echo "None"
fi

cat <<EOF

## Code

[See code on GitHub](https://github.com/uniget-org/tools/tree/main/tools/${tool})

## Package

[See package on GitHub](https://github.com/uniget-org/tools/pkgs/container/uniget%2F${tool})

## Platforms

EOF
PLATFORMS="$(
    jq --raw-output 'select(.platforms != null) | .platforms[] | "- \(.)"' <<<"${TOOL_JSON}"
)"
if test -z "${PLATFORMS}"; then
    echo '- linux/amd64'
else
    echo "${PLATFORMS}"
fi

cat <<EOF

## Messages

EOF
jq --raw-output 'select(.messages != null) | .messages | to_entries[] | "### \(.key)\n\n\(.value)"' <<<"${TOOL_JSON}"

cat <<EOF

## History

[Link](https://github.com/uniget-org/tools/commits/main/tools/${tool})
EOF
