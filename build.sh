#!/bin/bash
set -e
oracle_versions=( vendor/* )
logfile="log/build-$(date "+%Y%m%d%H%M%S").log"
touch "$logfile"
tag_prefix="tobiashm/ruby-instantclient"
while read -r ruby_version; do
  actual_ruby_version=$(docker run --rm "ruby:$ruby_version-slim" ruby -e "puts RUBY_VERSION")
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    version="$ruby_version-$oracle_version"
    for variant in basic basiclite; do
      tag="$tag_prefix:$version-$variant"
      actual_ruby_version_tag="$tag_prefix:$actual_ruby_version-$oracle_version-$variant"
      echo "Building $version-$variant ..."
      docker buildx build --load \
        --platform linux/amd64\
        -f "Dockerfile-$version-$variant" \
        -t "$tag" \
        -t "$actual_ruby_version_tag" . >> "$logfile" 2>&1

      if [ "$PUSH" ]; then
        docker push "$tag" >> "$logfile" 2>&1
        docker push "$actual_ruby_version_tag" >> "$logfile" 2>&1
      fi

      if [ "$variant" == "basiclite" ]; then
        default_tag="${tag%-$variant}"
        docker tag "$tag" "$default_tag" >> "$logfile" 2>&1

        if [ "$PUSH" ]; then
          docker push "$default_tag" >> "$logfile" 2>&1
        fi
      fi
    done
  done
done < ruby-versions
