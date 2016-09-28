#/bin/bash
set -e
oracle_versions=( vendor/* )
ruby_versions=( 2.*/ )
for ruby_version in "${ruby_versions[@]%/}"; do
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    docker build . -f $ruby_version/$oracle_version/Dockerfile -t "tobiashm/ruby-instantclient:$ruby_version-$oracle_version"
  done
done
