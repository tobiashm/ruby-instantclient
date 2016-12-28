#!/bin/bash
set -e
oracle_versions=( vendor/* )
while read ruby_version; do
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    docker build . -f "Dockerfile-$ruby_version-$oracle_version" -t "tobiashm/ruby-instantclient:$ruby_version-$oracle_version"
  done
done < ruby-versions
