#!/bin/bash
set -e
oracle_versions=( vendor/* )
logfile="log/build-$(date "+%Y%m%d%H%M%S").log"
touch "$logfile"
while read ruby_version; do
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    version="$ruby_version-$oracle_version"
    for variant in basic basiclite; do
      tag="tobiashm/ruby-instantclient:$version-$variant"
      echo "Building $version-$variant ..."
      docker build . -f "Dockerfile-$version-$variant" -t "$tag" 2>&1 >> "$logfile"
      if [ "$PUSH" ]; then docker push "$tag" 2>&1 >> "$logfile"; fi
      if [ "$variant" == "basiclite" ]; then
        default_tag="${tag%-$variant}"
        docker tag "$tag" "$default_tag" 2>&1 >> "$logfile"
        if [ "$PUSH" ]; then docker push "$default_tag" 2>&1 >> "$logfile"; fi
      fi
    done
  done
done < ruby-versions
