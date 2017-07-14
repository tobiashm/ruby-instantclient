#!/bin/bash
set -e
oracle_versions=( vendor/* )
while read ruby_version; do
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    version="$ruby_version-$oracle_version"
    for variant in basic basiclite; do
      tag="tobiashm/ruby-instantclient:$version-$variant"
      docker build . -f "Dockerfile-$version-$variant" -t "$tag"
      if [ "$PUSH" ]; then docker push "$tag"; fi
      if [ "$variant" == "basiclite" ]; then
        default_tag="${tag%-$variant}"
        docker tag "$tag" "$default_tag"
        if [ "$PUSH" ]; then docker push "$default_tag"; fi
      fi
    done
  done
done < ruby-versions
