#!/usr/bin/env bash
set -euo pipefail

RESTART=${h:-false}

if [ ${RESTART} == "true" ]; then
    echo ${RESTART}
fi
