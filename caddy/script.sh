#!/bin/bash
set -e

# -------------------------
# with arguments
# -------------------------
REPOSITORY="draftmode/kernel.caddy"
# -------------------------

# -------------------------
# source snippets
# -------------------------
SCRIPT_PATH="/home/admin/projects/draftm0de/projects/kernel.deployment"

echo "[Notice] Build image..."
BUILT_IMAGE_NAME="$REPOSITORY:latest"
# ("${SCRIPT_PATH}/docker.sh" "build" "--build-args=.build_args" "-t $BUILT_IMAGE_NAME" ".")
echo "[Notice] > build successfully"

# get local SHA from built image
echo "[Notice] Protect built SHA against remote"
# SHA=$("${SCRIPT_PATH}/docker.sh" "image sha" "$BUILT_IMAGE_NAME")
echo "[Notice] Local SHA:$SHA"
# ("${SCRIPT_PATH}/docker.sh" "image tags" "$REPOSITORY" "--remote" "--sha=$SHA" "--exists")
echo "[Notice] > Protection successfully"

# get local SHA from built image
echo "[Notice] Get latest remote tag for $BUILT_IMAGE_NAME "
# LATEST_TAG=$("${SCRIPT_PATH}/docker.sh" "image tags" "$BUILT_IMAGE_NAME" "--remote" "--latest=patch")
echo "[Notice] > latest remote tag for $BUILT_IMAGE_NAME: $LATEST_TAG"

echo "[Notice] Tag docker image"
LATEST_TAG=""
# TAGS=$("${SCRIPT_PATH}/docker.sh" "image tag" "$BUILT_IMAGE_NAME" "$REPOSITORY:${LATEST_TAG:-0.0.0}" "--tag-increase=1.2" "--tag-level=3")
TAGS=$("${SCRIPT_PATH}/docker.sh" "image tag" "$BUILT_IMAGE_NAME" "$REPOSITORY:${LATEST_TAG:-0.0.0}" "--tag-increase=0.0" "--tag-level=3")
echo "[Notice] > docker image tagged successfully"

echo "[Notice] Push docker images"
# shellcheck disable=SC2206
TAGS=($TAGS)
TAGS+=("$BUILT_IMAGE_NAME")
for TAG in "${TAGS[@]}"; do
  echo "docker push $TAG"
done
echo "[Notice] > Pushing docker images successfully"
