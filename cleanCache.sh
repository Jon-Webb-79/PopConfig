#!/bin/bash

set -euo pipefail

# Configuration
CACHE_DIR="$HOME/.cache"
LOGFILE="$HOME/.cache_cleanup.log"
MIN_SIZE_MB=100          # Only delete entries larger than this (in MB)
OLDER_THAN_DAYS=30       # Only delete entries older than this (in days)
DRY_RUN=true             # Set to false to actually delete

# Function to print log entries
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOGFILE"
}

log "Started selective cache cleanup (dry-run: $DRY_RUN)"
log "Criteria: size >= ${MIN_SIZE_MB}MB, age >= ${OLDER_THAN_DAYS} days"

# Find directories matching criteria
mapfile -t TARGETS < <(find "$CACHE_DIR" -mindepth 1 -maxdepth 1 -type d \
    -size +"${MIN_SIZE_MB}"M -mtime +"$OLDER_THAN_DAYS")

if [[ "${#TARGETS[@]}" -eq 0 ]]; then
    log "No cache directories matched the cleanup criteria."
else
    for target in "${TARGETS[@]}"; do
        if [[ "$DRY_RUN" == true ]]; then
            log "Would delete: $target"
        else
            rm -rf "$target" && log "Deleted: $target" || log "Failed to delete: $target"
        fi
    done
fi

log "Finished selective cache cleanup"

