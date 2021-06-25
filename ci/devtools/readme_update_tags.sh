#!/bin/bash

# start with a clean environment
[ -n "${DOCKER_ORG:-}" ] ||
[ -n "${IMAGE_NAME:-}" ] ||
[ -n "${GOSU_VERSION:-}" ] ||
[ -n "${RUST_CROSS_TARGETS:-}" ] ||
[ -n "${JDK_JVM:-}" ] ||
[ -n "${MVN_VERSION:-}" ] ||
[ -n "${BASE_IMAGE:-}" ] ||
[ -n "${FLAVORS:-}" ] ||
[ -n "${CARGO_AUDIT_VERSION:-}" ] ||
[ -n "${COMBINE:-}" ] &&
exec -c "$0"

export SKIP_LOGIN="true"
export SKIP_BUILD="true"

workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." &> /dev/null && pwd )"
mapfile -t globals < <(docker run --rm -v "$workdir":/workdir mikefarah/yq e '.env.global.[]' .travis.yml)
mapfile -t runners < <(docker run --rm -v "$workdir":/workdir mikefarah/yq e '.env.jobs.[]' .travis.yml)

sed -i '/^### Currently available tags/q' "$workdir"/README.md
# shellcheck disable=SC2129
echo '```' >> "$workdir"/README.md
for i in "${!runners[@]}"; do
  # shellcheck disable=SC1090
  ( source <(for var in "${globals[@]}"; do echo "export $var"; done; echo "export ${runners[$i]}"); \
  "$workdir"/ci/script.sh 2>&1 | grep -v "AS" | grep "${IMAGE_NAME:-}" )
done | sort >> "$workdir"/README.md
echo '```' >> "$workdir"/README.md
