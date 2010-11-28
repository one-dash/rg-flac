#!/bin/sh

# finds flac music in your collection without replaygain data and adds it to
# them

find . -type f -name "*.flac" | while read file; do dirname "${file}" ; done | sort | uniq | while read dir; do cd "${dir}" && { pwd; { for i in *.flac ; do metaflac --export-tags=- "$i" | grep -q REPLAYGAIN || echo found_no_replay_gain_tracks ; done; } | grep found_no_replay_gain_tracks && metaflac --add-replay-gain *.flac ; cd -; } ; done
