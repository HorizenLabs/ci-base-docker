![Travis (.com) branch](https://img.shields.io/travis/com/HorizenOfficial/sc-ci-base-docker/master) ![Docker Stars](https://img.shields.io/docker/stars/zencash/sc-ci-base.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/zencash/sc-ci-base.svg)

## Docker base images for Zendoo CI pipelines

### About
Provides Docker base images for CI pipelines of the following Zendoo repositories:
- [ginger-lib](https://github.com/HorizenOfficial/ginger-lib)
- [marlin](https://github.com/HorizenLabs/marlin)
- [poly-commit](https://github.com/HorizenLabs/poly-commit)
- [zendoo-cctp-lib](https://github.com/HorizenOfficial/zendoo-cctp-lib)
- [zendoo-mc-cryptolib](https://github.com/HorizenOfficial/zendoo-mc-cryptolib)
- [zendoo-sc-cryptolib](https://github.com/HorizenOfficial/zendoo-sc-cryptolib)

Multiple images in various combinations are being built. They can be generalized into three types:
1. Rust, default gcc and mingw toolchain for Ubuntu and Debian Linux with the Rust cross compile target for x86_64-pc-windows-gnu installed
2. OpenJDK, installed from https://adoptium.net/ and Maven for Ubuntu and Debian Linux
3. A combination of 1. and 2. with both Rust and OpenJDK

- For the Rust images `1.51.0`, `stable`, `nightly` and `nightly-2021-04-25` based images are built
- For the OpenJDK images JDK versions `8`, `11` and `17` (at the time of writing the latest available LTS JDK versions) are built
- For the images containing both Rust and OpenJDK combinations of all available versions are built

For all of these images versions from the following base images are being built:
- `ubuntu:bionic`
- `ubuntu:focal`
- `ubuntu:jammy`
- `debian:buster`
- `debian:bullseye`

The images are tagged using the followig schema:
```
zencash/sc-ci-base:{bionic,focal,jammy,buster,bullseye}_rust-{1.51.0,stable,nightly,nightly-2021-04-25}_{$(date +%Y%m%d),latest};
zencash/sc-ci-base:{bionic,focal,jammy,buster,bullseye}_jdk-{8,11,17}_{$(date +%Y%m%d),latest};
zencash/sc-ci-base:{bionic,focal,jammy,buster,bullseye}_rust-{1.51.0,stable,nightly,nightly-2021-04-25}_jdk-{8,11,17}_{$(date +%Y%m%d),latest};
```

### Currently available tags (only latest shown)
```
zencash/sc-ci-base:bionic_jdk-11_latest
zencash/sc-ci-base:bionic_jdk-17_latest
zencash/sc-ci-base:bionic_jdk-8_latest
zencash/sc-ci-base:bionic_rust-1.51.0_jdk-11_latest
zencash/sc-ci-base:bionic_rust-1.51.0_jdk-17_latest
zencash/sc-ci-base:bionic_rust-1.51.0_jdk-8_latest
zencash/sc-ci-base:bionic_rust-1.51.0_latest
zencash/sc-ci-base:bionic_rust-nightly-2021-04-25_jdk-11_latest
zencash/sc-ci-base:bionic_rust-nightly-2021-04-25_jdk-17_latest
zencash/sc-ci-base:bionic_rust-nightly-2021-04-25_jdk-8_latest
zencash/sc-ci-base:bionic_rust-nightly-2021-04-25_latest
zencash/sc-ci-base:bionic_rust-nightly_jdk-11_latest
zencash/sc-ci-base:bionic_rust-nightly_jdk-17_latest
zencash/sc-ci-base:bionic_rust-nightly_jdk-8_latest
zencash/sc-ci-base:bionic_rust-nightly_latest
zencash/sc-ci-base:bionic_rust-stable_jdk-11_latest
zencash/sc-ci-base:bionic_rust-stable_jdk-17_latest
zencash/sc-ci-base:bionic_rust-stable_jdk-8_latest
zencash/sc-ci-base:bionic_rust-stable_latest
zencash/sc-ci-base:bullseye_jdk-11_latest
zencash/sc-ci-base:bullseye_jdk-17_latest
zencash/sc-ci-base:bullseye_jdk-8_latest
zencash/sc-ci-base:bullseye_rust-1.51.0_jdk-11_latest
zencash/sc-ci-base:bullseye_rust-1.51.0_jdk-17_latest
zencash/sc-ci-base:bullseye_rust-1.51.0_jdk-8_latest
zencash/sc-ci-base:bullseye_rust-1.51.0_latest
zencash/sc-ci-base:bullseye_rust-nightly-2021-04-25_jdk-11_latest
zencash/sc-ci-base:bullseye_rust-nightly-2021-04-25_jdk-17_latest
zencash/sc-ci-base:bullseye_rust-nightly-2021-04-25_jdk-8_latest
zencash/sc-ci-base:bullseye_rust-nightly-2021-04-25_latest
zencash/sc-ci-base:bullseye_rust-nightly_jdk-11_latest
zencash/sc-ci-base:bullseye_rust-nightly_jdk-17_latest
zencash/sc-ci-base:bullseye_rust-nightly_jdk-8_latest
zencash/sc-ci-base:bullseye_rust-nightly_latest
zencash/sc-ci-base:bullseye_rust-stable_jdk-11_latest
zencash/sc-ci-base:bullseye_rust-stable_jdk-17_latest
zencash/sc-ci-base:bullseye_rust-stable_jdk-8_latest
zencash/sc-ci-base:bullseye_rust-stable_latest
zencash/sc-ci-base:buster_jdk-11_latest
zencash/sc-ci-base:buster_jdk-17_latest
zencash/sc-ci-base:buster_jdk-8_latest
zencash/sc-ci-base:buster_rust-1.51.0_jdk-11_latest
zencash/sc-ci-base:buster_rust-1.51.0_jdk-17_latest
zencash/sc-ci-base:buster_rust-1.51.0_jdk-8_latest
zencash/sc-ci-base:buster_rust-1.51.0_latest
zencash/sc-ci-base:buster_rust-nightly-2021-04-25_jdk-11_latest
zencash/sc-ci-base:buster_rust-nightly-2021-04-25_jdk-17_latest
zencash/sc-ci-base:buster_rust-nightly-2021-04-25_jdk-8_latest
zencash/sc-ci-base:buster_rust-nightly-2021-04-25_latest
zencash/sc-ci-base:buster_rust-nightly_jdk-11_latest
zencash/sc-ci-base:buster_rust-nightly_jdk-17_latest
zencash/sc-ci-base:buster_rust-nightly_jdk-8_latest
zencash/sc-ci-base:buster_rust-nightly_latest
zencash/sc-ci-base:buster_rust-stable_jdk-11_latest
zencash/sc-ci-base:buster_rust-stable_jdk-17_latest
zencash/sc-ci-base:buster_rust-stable_jdk-8_latest
zencash/sc-ci-base:buster_rust-stable_latest
zencash/sc-ci-base:focal_jdk-11_latest
zencash/sc-ci-base:focal_jdk-17_latest
zencash/sc-ci-base:focal_jdk-8_latest
zencash/sc-ci-base:focal_rust-1.51.0_jdk-11_latest
zencash/sc-ci-base:focal_rust-1.51.0_jdk-17_latest
zencash/sc-ci-base:focal_rust-1.51.0_jdk-8_latest
zencash/sc-ci-base:focal_rust-1.51.0_latest
zencash/sc-ci-base:focal_rust-nightly-2021-04-25_jdk-11_latest
zencash/sc-ci-base:focal_rust-nightly-2021-04-25_jdk-17_latest
zencash/sc-ci-base:focal_rust-nightly-2021-04-25_jdk-8_latest
zencash/sc-ci-base:focal_rust-nightly-2021-04-25_latest
zencash/sc-ci-base:focal_rust-nightly_jdk-11_latest
zencash/sc-ci-base:focal_rust-nightly_jdk-17_latest
zencash/sc-ci-base:focal_rust-nightly_jdk-8_latest
zencash/sc-ci-base:focal_rust-nightly_latest
zencash/sc-ci-base:focal_rust-stable_jdk-11_latest
zencash/sc-ci-base:focal_rust-stable_jdk-17_latest
zencash/sc-ci-base:focal_rust-stable_jdk-8_latest
zencash/sc-ci-base:focal_rust-stable_latest
zencash/sc-ci-base:jammy_jdk-11_latest
zencash/sc-ci-base:jammy_jdk-17_latest
zencash/sc-ci-base:jammy_jdk-8_latest
zencash/sc-ci-base:jammy_rust-1.51.0_jdk-11_latest
zencash/sc-ci-base:jammy_rust-1.51.0_jdk-17_latest
zencash/sc-ci-base:jammy_rust-1.51.0_jdk-8_latest
zencash/sc-ci-base:jammy_rust-1.51.0_latest
zencash/sc-ci-base:jammy_rust-nightly-2021-04-25_jdk-11_latest
zencash/sc-ci-base:jammy_rust-nightly-2021-04-25_jdk-17_latest
zencash/sc-ci-base:jammy_rust-nightly-2021-04-25_jdk-8_latest
zencash/sc-ci-base:jammy_rust-nightly-2021-04-25_latest
zencash/sc-ci-base:jammy_rust-nightly_jdk-11_latest
zencash/sc-ci-base:jammy_rust-nightly_jdk-17_latest
zencash/sc-ci-base:jammy_rust-nightly_jdk-8_latest
zencash/sc-ci-base:jammy_rust-nightly_latest
zencash/sc-ci-base:jammy_rust-stable_jdk-11_latest
zencash/sc-ci-base:jammy_rust-stable_jdk-17_latest
zencash/sc-ci-base:jammy_rust-stable_jdk-8_latest
zencash/sc-ci-base:jammy_rust-stable_latest
```
