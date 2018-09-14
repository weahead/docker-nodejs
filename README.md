# We ahead's Node.js in a container

Base image for developing Node.js applications.

[![Node.js 6.x: 6.9.5](https://img.shields.io/badge/Node.js--6.x:-6.9.5-green.svg)](https://github.com/weahead/docker-nodejs/tree/6.9.5)

## Layout of this repository

Check out the branches for each version of Node.js supported by this repository.


## Contents

This container includes:

- [S6 Overlay](https://github.com/just-containers/s6-overlay)
- [Node.js](https://nodejs.org/)
- [Git](https://git-scm.com/)


## Usage

See [example](example)

1. Create a `Dockerfile` with `FROM weahead/nodejs:<tag>`. Where `tag` is any
   tag listed at [https://hub.docker.com/r/weahead/nodejs/tags/](https://hub.docker.com/r/weahead/nodejs/tags/).

2. Create a folder named `app` next to `Dockerfile`.

3. Optionally, declare environment variables in docker-compose.yml files.
   NODE_ENV is properly set by default.

4. Add a `package.json` file to `app` folder and declare your dependencies.

   This gives you a folder structure like this:

   ```
   .
   ├── Dockerfile
   ├── app
   │   └── package.json
   └── ...
   ```

5. Build it with `docker build -t <name>:<tag> .`


## Node.js service - npm scripts

Upon startup of a container built from this base image, S6 will start a Node.js
service that will run a command depending on the value of the environment
variable `NODE_ENV`:

| Value       | Command         |
|-------------|-----------------|
| development | `npm run dev`   |
| production  | `npm run start` |

It is recommended you declare you run configuration in npm scrips section of
the `package.json` file. Watchers and things for `dev` and build and/or start
of webserver for `start`.


### S6 supervision

To use additional services S6 supervision can be used. More information on how
to use S6 can be found in [their documentation](https://github.com/just-containers/s6-overlay).

The recommended way is to use `COPY root /` in a descendant `Dockerfile` with
the directory structure found in [example/root](example/root).


## License

[X11](LICENSE)
