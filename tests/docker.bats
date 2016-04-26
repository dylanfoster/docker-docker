@test "provides access to docker" {
  docker run -t "${DOCKER_IMAGE_NAME}" docker --version
}
