#!/bin/bash
set -e
oracle_versions=( vendor/* )
tag_prefix="tobiashm/ruby-instantclient"
while read -r ruby_version; do
  actual_ruby_version=$(docker run --rm "ruby:$ruby_version-slim" ruby -e "puts RUBY_VERSION")
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    docker push "$tag_prefix:$ruby_version-$oracle_version"
    for variant in basic basiclite; do
      docker push "$tag_prefix:$ruby_version-$oracle_version-$variant"
      docker push "$tag_prefix:$actual_ruby_version-$oracle_version-$variant"
    done
  done
done < ruby-versions
