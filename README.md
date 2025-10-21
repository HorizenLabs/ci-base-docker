## Docker base images for CI pipelines

### About
Provides Docker base images for CI pipelines

Multiple images in various combinations can be built. They can be generalized into three types:
1. **Rust** - Includes the default GCC and MinGW toolchains for Ubuntu and Debian, along with Rust cross-compilation targets
2. **OpenJDK** - installed from https://adoptium.net/ and Maven for Ubuntu and Debian Linux
3. **Combined** - Contains both Rust and OpenJDK toolchains in a single image

Below are examples of how to build different image combinations:
```shell
# --- Combined builds ---
- base-image: debian:buster
  flavor: rust-1.51.0
  combine: "rust-1.51.0;jdk-8,jdk-11,jdk-17"
  display-name: "Debian Buster + Rust 1.51.0 + Combined JDK"

- base-image: debian:buster
  flavor: rust-stable
  combine: "rust-stable;jdk-8,jdk-11,jdk-17"
  display-name: "Debian Buster + Rust Stable + Combined JDK"

- base-image: debian:buster
  flavor: rust-nightly
  combine: "rust-nightly;jdk-8,jdk-11,jdk-17"
  display-name: "Debian Buster + Rust Nightly + Combined JDK"

- base-image: debian:buster
  flavor: rust-nightly-2021-04-25
  combine: "rust-nightly-2021-04-25;jdk-8,jdk-11,jdk-17"
  display-name: "Debian Buster + Rust Nightly 2021-04-25 + Combined JDK"
```

For more details and available tags, see the Docker Hub repository: [horizenlabs/ci-base](https://hub.docker.com/r/horizenlabs/ci-base)