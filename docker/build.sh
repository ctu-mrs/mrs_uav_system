# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

cd $MY_PATH

LOCAL_TAG=mrs_uav_system:b3m33mrs
REGISTRY=ctumrs

docker buildx create --name container --driver=docker-container
docker buildx build . --file ./old_system -t "$REGISTRY/$LOCAL_TAG" --platform=linux/arm64 --progress=plain

# docker push "$REGISTRY/$LOCAL_TAG"
