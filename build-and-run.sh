source .env
docker build . -t $IMAGE_NAME
docker run -it --rm -p ${PORT:-22}:22 -p 8080:80 $IMAGE_NAME
