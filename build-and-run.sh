source .env
docker build . -t $IMAGE_NAME
# docker run -it --rm -p ${SSH_PORT:-22}:22 -p ${HTTP_PORT:-80}:80 $IMAGE_NAME
docker run -v /var/run/docker.sock:/var/run/docker.sock -it --rm -p ${SSH_PORT:-22}:22 -p ${HTTP_PORT:-80}:80 $IMAGE_NAME
