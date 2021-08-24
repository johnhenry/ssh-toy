# Herokito

https://www.reddit.com/r/selfhosted/comments/b9bu91/self_hosted_netlifylike_solution/
https://github.com/ynohat/git-http-backend

Like heroku, but as a docker container.

Heroku is most famous for allowing developers to deploy code by pushing to git.

This is a demonstration of how to run a similar service in heroku.

## User

There exists a single non-root user named `git`.

## Directories

User `git` owns three top level directories:

- `/git`
  - home directory
- `/live`
  - static directory
  - served on port 80
  - symbolically linked as `/git/live`
- `/www`
  - git repository
  - runs `/www/.git/hooks/post-receive` upon receiving push
  - symbolically linked as `/git/www`

## Post-recieve

This (`/www/.git/hooks/post-receive`) script fires after a successful push to the get repository at `/www/`.

It is currently set up to copy files from `/www` into `/live` in order to be served.

## clone

## ssh

## Environment

The .env file is used to define default values for variables used in scripts.

### Variables

IMAGE_NAME

Defines the name of image to be built, rebuilt, and run

- default: ssh-toy

SSH_PORT

- default: 23

HTTP_PORT

- default: 8080

## Build and Run Image

- run `sh build-and-run.sh` to build and run [the] image.
- <kbd>ctrl</kbd> + <kbd>c</kbd> to shutdown

Note:
Everytime you build a new image, it will have a new and different SSH key.
If you use the same address to access it again,
you'll likely need to remove the key for said address from `~/.ssh/known_hosts`
before you can access

git clone ssh://git@localhost:23/www

http://localhost:8080

{}
