#!/bin/bash
set -e

IMAGE_NAME="ubuntu22.04-cu12.8.1-torch2.10.0"
REGISTRY="registry.cluster.local/user_linaifan"
TAG="v1.0"

DOCKER_BUILDKIT=1 docker build \
	-f Dockerfile.jammy \
	-t ${IMAGE_NAME}:${TAG} \
	-t ${REGISTRY}/${IMAGE_NAME}:${TAG} \
	.

echo ""
echo "构建完成！推送镜像请运行："
echo "  docker push ${REGISTRY}/${IMAGE_NAME}:${TAG}"
