#!/bin/bash
set -e
oracle_versions=( vendor/* )
while read -r ruby_version; do
  echo "## Ruby $ruby_version"
  actual_ruby_version=$(docker run --rm "ruby:$ruby_version-slim" ruby -e "puts RUBY_VERSION")
  for oracle_version in "${oracle_versions[@]#vendor/}"; do
    echo -n "- "
    echo -n "\`$actual_ruby_version-$oracle_version-basiclite\`"
    echo -n ", \`$ruby_version-$oracle_version-basiclite\`"
    echo -n ", \`$ruby_version-$oracle_version\`"
    echo ""
    echo -n "- "
    echo -n "\`$ruby_version-$oracle_version-basic\`"
    echo -n ", \`$actual_ruby_version-$oracle_version-basic\`"
    echo ""
  done
  echo ""
done < ruby-versions
