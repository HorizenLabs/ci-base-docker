## Docker base images for CI pipelines

### About
Provides Docker base images for CI pipelines

Multiple images in various combinations can be built. They can be generalized into three types:
1. **Rust** - Includes the default GCC and MinGW toolchains for Ubuntu and Debian, along with Rust cross-compilation targets
2. **OpenJDK** - installed from https://adoptium.net/ and Maven for Ubuntu and Debian Linux
3. **Combined** - Contains both Rust and OpenJDK toolchains in a single image

For more details and available tags, see the Docker Hub repository: [horizenlabs/ci-base](https://hub.docker.com/r/horizenlabs/ci-base)