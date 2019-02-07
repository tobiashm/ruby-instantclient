#!/bin/bash
set -e
oracle_versions=( vendor/* )
while read ruby_version; do
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    version="$ruby_version-$oracle_version"
    for variant in basic basiclite; do
      tag="tobiashm/ruby-instantclient:$version-$variant"
      docker push "$tag"
      if [ "$variant" == "basiclite" ]; then
        default_tag="${tag%-$variant}"
        docker push "$default_tag"
      fi
    done
  done
done < ruby-versions
