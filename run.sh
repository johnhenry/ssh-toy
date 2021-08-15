source .env
docker run -it --rm -p $PORT:22 -p 8080:80  $IMAGE_NAME
