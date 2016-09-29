#/bin/bash
set -e
oracle_versions=( vendor/* )
while read ruby_version; do
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    for package in basic basiclite; do
      sedStr="
        s!%%ORACLE_VERSION%%!$oracle_version!g;
        s!%%PACKAGE%%!$package!g
        s!%%RUBY_VERSION%%!$ruby_version!g;
      "
      sed -e "$sedStr" "Dockerfile.template" > "Dockerfile-$ruby_version-$oracle_version-$package"
    done
  done
done < ruby-versions
