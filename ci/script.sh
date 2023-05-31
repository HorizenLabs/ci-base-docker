#!/bin/bash

set -euo pipefail

get_work () {
  # create array of images and build args, each element of format 'build_arg1,build_arg2,...;image_tag;dockerfile'
  local build_args=""
  local image_tag=""
  local dockerfile=""
  # add single flavor images to BUILD
  for flavor in $(tr "," " " <<< "$FLAVORS"); do
    build_args=""
    image_tag=""
    dockerfile=""
    build_args+="FROM_IMAGE=${BASE_IMAGE},"
    build_args+="ARG_GOSU_VERSION=${GOSU_VERSION},"
    if grep -q rust <<< "$flavor"; then
      build_args+="ARG_RUST_TOOLCHAIN=$(cut -d- -f2- <<< "$flavor"),"
      build_args+="ARG_CARGO_AUDIT_VERSION_OLD_RUST=${CARGO_AUDIT_VERSION_OLD_RUST},"
      build_args+="ARG_RUST_CROSS_TARGETS=${RUST_CROSS_TARGETS};"
      image_tag="${CODENAME}_${flavor}_latest;"
      dockerfile="./dockerfiles/${DISTRIBUTION}/Dockerfile_rust"
    fi
    if grep -q jdk <<< "$flavor"; then
      build_args+="ARG_JDK_VERSION=$(cut -d- -f2- <<< "$flavor");"
      image_tag="${CODENAME}_${flavor}_latest;"
      dockerfile="./dockerfiles/${DISTRIBUTION}/Dockerfile_jdk"
    fi
    BUILD+=( "${build_args}${image_tag}${dockerfile}" )
  done
  # add combined flavor images to BUILD
  local element=""
  if [ -n "${COMBINE:-}" ]; then
    local first_img=()
    local second_img=()
    local first=""
    local second=""
    # base images
    mapfile -t first_img < <(cut -d";" -f1 <<< "$COMBINE" | tr "," "\n")
    # second level images to build on top of base images
    mapfile -t second_img < <(cut -d";" -f2 <<< "$COMBINE" | tr "," "\n")
    for element in "${BUILD[@]}"; do
      for first in "${first_img[@]}"; do
        if grep -q "$first" <<< "$element"; then
          for second in "${second_img[@]}"; do
            build_args=""
            image_tag=""
            dockerfile=""
            build_args+="ARG_GOSU_VERSION=${GOSU_VERSION},"
            if grep -q rust <<< "$second"; then
              build_args+="FROM_IMAGE=${DOCKER_ORG}/${IMAGE_NAME}:${CODENAME}_${first}_latest,"
              build_args+="ARG_RUST_TOOLCHAIN=$(cut -d- -f2- <<< "$second"),"
              build_args+="ARG_CARGO_AUDIT_VERSION_OLD_RUST=${CARGO_AUDIT_VERSION_OLD_RUST},"
              build_args+="ARG_RUST_CROSS_TARGETS=${RUST_CROSS_TARGETS};"
              image_tag="${CODENAME}_${first}_${second}_latest;"
              dockerfile="./dockerfiles/${DISTRIBUTION}/Dockerfile_rust"
            fi
            if grep -q jdk <<< "$second"; then
              build_args+="FROM_IMAGE=${DOCKER_ORG}/${IMAGE_NAME}:${CODENAME}_${first}_latest,"
              build_args+="ARG_JDK_VERSION=$(cut -d- -f2- <<< "$second");"
              image_tag="${CODENAME}_${first}_${second}_latest;"
              dockerfile="./dockerfiles/${DISTRIBUTION}/Dockerfile_jdk"
            fi
            BUILD+=( "${build_args}${image_tag}${dockerfile}" )
          done
        fi
      done
    done
  fi
  # for each element in BUILD add to TAGS where we replace '_latest' with '_$DATE'
  echo "Images to build:"
  for element in "${BUILD[@]}"; do
    TAGS+=( "${element//_latest/_$DATE}" )
    echo "${DOCKER_ORG}/${IMAGE_NAME}:$(cut -d";" -f2 <<< "$element")"
  done
  echo
  echo "Images to tag:"
  local i=0
  for i in "${!BUILD[@]}"; do
    echo "${DOCKER_ORG}/${IMAGE_NAME}:$(cut -d";" -f2 <<< "${BUILD[$i]}") AS ${DOCKER_ORG}/${IMAGE_NAME}:$(cut -d";" -f2 <<< "${TAGS[$i]}")"
  done
}

build_images () {
  local image=""
  local args=""
  local arg=""
  local tag=""
  local dockerfile=""
  for image in "${BUILD[@]}"; do
    args=""
    for arg in $(cut -d";" -f1 <<< "$image" | tr "," " "); do
      args+=" --build-arg $arg"
    done
    tag="${DOCKER_ORG}/${IMAGE_NAME}:$(cut -d";" -f2 <<< "$image")"
    dockerfile="$(cut -d";" -f3 <<< "$image")"
    echo "Running docker build$args -t $tag -f $dockerfile ."
    # shellcheck disable=SC2086
    docker build$args -t "$tag" -f "$dockerfile" .
  done
}

tag_images () {
  local i=0
  for i in "${!BUILD[@]}"; do
    echo "Tagging ${DOCKER_ORG}/${IMAGE_NAME}:$(cut -d";" -f2 <<< "${BUILD[$i]}") AS ${DOCKER_ORG}/${IMAGE_NAME}:$(cut -d";" -f2 <<< "${TAGS[$i]}")"
    docker tag "${DOCKER_ORG}/${IMAGE_NAME}:$(cut -d";" -f2 <<< "${BUILD[$i]}")" "${DOCKER_ORG}/${IMAGE_NAME}:$(cut -d";" -f2 <<< "${TAGS[$i]}")"
  done
}

push_images () {
  local image=""
  for image in $(docker image ls --filter=reference="${DOCKER_ORG}/${IMAGE_NAME}" --format "{{.Repository}}:{{.Tag}}"); do
    echo "Pushing $image to registry"
    docker push "$image"
  done
}

DATE="$(date +%Y%m%d)"
DISTRIBUTION="$(cut -d: -f1 <<< "$BASE_IMAGE")"
CODENAME="$(cut -d: -f2 <<< "$BASE_IMAGE")"
BUILD=()
TAGS=()
get_work
if [ -z "${SKIP_LOGIN:-}" ]; then
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
fi
if [ -z "${SKIP_BUILD:-}" ]; then
  build_images
  tag_images
fi
if [ "${TRAVIS_BRANCH:-x}" = "master" ]; then
  push_images
fi
