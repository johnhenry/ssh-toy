The repo sets up an application that accepts pushes via git
and builds the result a custom directory to be served.

## Usage

#### Build and Run Image

Note:
Everytime you build, the image created will have a new and different SSH key.
If you use the same address to acces it again,
you'll likely need to remove the key for said address from `~/.ssh/known_hosts`

and run the image again, a different SSH key

git clone ssh://git@localhost:23/www
