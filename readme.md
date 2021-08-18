The repo sets up an application that accepts pushes via git
and builds the result a custom directory to be served.

## User: git

There exists a single non-root user named "git" who has access to `/git` and its subdirectoies.
A special directory, `/git/deployed` is symbolically linked as `/deployed` and served on port 80.
Another special directory, `/git/www` is symbolically linked as `/www` is a .

/git/www and /git/deployed.
(aliased as )

There is a user named "git" with no security, that is

th

"git" has no security, so you can push and

This user has no security

There is a get repo located at repository located at /www.
There i

git clone ssh://deploy@localhost:23/

## Usage

#### Build and Run Image

Note:
Everytime you build, the image created will have a new and different SSH key.
If you use the same address to acces it again,
you'll likely need to remove the key for said address from `~/.ssh/known_hosts`

and run the image again, a different SSH key

git clone ssh://git@localhost:23/www
