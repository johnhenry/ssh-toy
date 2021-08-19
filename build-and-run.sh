source .env
docker build . -t $IMAGE_NAME
docker run -it --rm -p ${SSH_PORT:-22}:22 -p ${HTTP_PORT:-80}:80 $IMAGE_NAME
