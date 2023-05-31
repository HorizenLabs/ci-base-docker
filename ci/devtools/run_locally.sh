#!/bin/bash

# start with a clean environment
[ -n "${DOCKER_ORG:-}" ] ||
[ -n "${IMAGE_NAME:-}" ] ||
[ -n "${GOSU_VERSION:-}" ] ||
[ -n "${RUST_CROSS_TARGETS:-}" ] ||
[ -n "${JDK_JVM:-}" ] ||
[ -n "${BASE_IMAGE:-}" ] ||
[ -n "${FLAVORS:-}" ] ||
[ -n "${CARGO_AUDIT_VERSION:-}" ] ||
[ -n "${COMBINE:-}" ] &&
exec -c "$0"

export SKIP_LOGIN="true"

workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../.." &> /dev/null && pwd )"
mapfile -t globals < <(docker run --rm -v "$workdir":/workdir mikefarah/yq e '.env.global.[]' .travis.yml)
mapfile -t runners < <(docker run --rm -v "$workdir":/workdir mikefarah/yq e '.env.jobs.[]' .travis.yml)

for i in "${!runners[@]}"; do
  # shellcheck disable=SC1090
  ( source <(for var in "${globals[@]}"; do echo "export $var"; done; echo "export ${runners[$i]}"); \
  "$workdir"/ci/script.sh 2>&1 | tee -a "$workdir/ci/devtools/job-$i.log" )
done
