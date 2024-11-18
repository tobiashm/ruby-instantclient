#!/bin/bash
set -e
oracle_versions=( vendor/* )
tag_prefix="tobiashm/ruby-instantclient"
while read -r ruby_version; do
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    version="$ruby_version-$oracle_version"
    for variant in basic basiclite; do
      docker pull "$tag_prefix:$version-$variant"
    done
  done
done < ruby-versions
