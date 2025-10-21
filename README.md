## Docker base images for CI pipelines

### About
Provides Docker base images for CI pipelines

Multiple images in various combinations can be built. They can be generalized into three types:
1. **Rust** - Includes the default GCC and MinGW toolchains for Ubuntu and Debian, along with Rust cross-compilation targets
2. **OpenJDK** - installed from https://adoptium.net/ and Maven for Ubuntu and Debian Linux
3. **Combined** - Contains both Rust and OpenJDK toolchains in a single image

Below are examples of how to build different image combinations using environmental variables: 
```shell
- BASE_IMAGE=debian:buster FLAVORS=rust-1.51.0 COMBINE='rust-1.51.0;jdk-8,jdk-11,jdk-17'
- BASE_IMAGE=debian:buster FLAVORS=rust-stable COMBINE='rust-stable;jdk-8,jdk-11,jdk-17'
- BASE_IMAGE=debian:buster FLAVORS=rust-nightly COMBINE='rust-nightly;jdk-8,jdk-11,jdk-17'
- BASE_IMAGE=debian:buster FLAVORS=rust-nightly-2021-04-25 COMBINE='rust-nightly-2021-04-25;jdk-8,jdk-11,jdk-17'
- BASE_IMAGE=debia:buster FLAVORS=jdk-8,jdk-11,jdk-17
```

### Currently available tags (only latest shown)
```
horizenlabs/sc-ci-base:bookworm_rust-nightly_latest
horizenlabs/sc-ci-base:bookworm_rust-stable_latest
horizenlabs/sc-ci-base:bullseye_rust-nightly_latest
horizenlabs/sc-ci-base:bullseye_rust-stable_latest
horizenlabs/sc-ci-base:jammy_rust-nightly_latest
horizenlabs/sc-ci-base:jammy_rust-stable_latest
horizenlabs/sc-ci-base:noble_rust-nightly_latest
horizenlabs/sc-ci-base:noble_rust-stable_latest
```