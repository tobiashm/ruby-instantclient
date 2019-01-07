#!/bin/bash
set -e
while read ruby_version; do
  docker pull "ruby:${ruby_version}-slim"
done < ruby-versions
