#/bin/bash
set -e
oracle_versions=( vendor/* )
ruby_versions=( 2.*/ )
for ruby_version in "${ruby_versions[@]%/}"; do
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    mkdir -p "$ruby_version/$oracle_version"
    sedStr="
      s!%%ORACLE_VERSION%%!$oracle_version!g;
      s!%%RUBY_VERSION%%!$ruby_version!g;
    "
    sed -e "$sedStr" "Dockerfile.template" > "$ruby_version/$oracle_version/Dockerfile"
  done
done
