# Immutant on Docker

## How this container works

When this container is run, it scans directories at /servers/* for
Immutant deployment descriptors, copies them to the standalone
deployments directory, and adds a deployment marker file for
each. Then it starts up Immutant via it's standalone.sh script.

## Using this Docker container

Each project you'd like to deploy should come in the form of a Docker
container that has an Immutant archive mounted in a volume somewhere
in /servers/. For example, your project might have a Dockerfile
something like this:

```
FROM stackbrew/ubuntu:13.10

VOLUME ["/servers/my-immutant-project/"]

ADD target/my-immutant-project.ima /servers/my-immutant-project/
ADD resources/immutant/my-immutant-project.clj /servers/my-immutant-project/
```

Then, when you run the Immutant container, you attach each project's
Docker container with the `--volumes-from` flag. For example:

```sh
docker run -t -i --volumes-from my-immutant-project immutant-docker
```

You can attach as many such volumes as you find reasonable.

And however you change your projects, the Immuntant container doesn't
need to be changed. Just attach different containers to it.

## Caveats

* This was an afternoon's worth of experimentation, so it might only
  be good for a very specific use-case. And even still, maybe not good
  for that.
* Immutant is not run under any sort of supervisor, so when it dies,
  it dies.
* There may very well be much better ways to do this.
