# jjmerelo/raku container

This is a bare-bones, lightweight, image that contains the bare
[`raku`](https://raku.org) executables, without any frills. It's been created
mainly for lightweightness, and as a base for a family of images.

This is intended mainly as a base image, not so much for direct use. Could be
useful for CI, though.

It includes a non-privileged user, also called `raku`, with its home
directory. Binaries for `raku` are installed in privileged directories, however.

## Availability

Available from major registries:
* [DockerHub](https://hub.docker.com/r/jjmerelo/raku)
* [GHCR](https://github.com/JJ/docker-raku/pkgs/container/raku)

## Versions

Images for all [Raku](https://raku.org) release from the beginning of 2020 [have
been released](https://hub.docker.com/r/jjmerelo/raku/tags).

They come in two flavors

* Regular, such as
  [2021.10](https://hub.docker.com/layers/jjmerelo/raku/2021.10/images/sha256-e48fc8148775ca9b81e73271caedb4700c80fff7ee7555363910bd77a8415fa6?context=explore).

* `gha`, essentially the same, except the `raku` user has 1001 as UID. This is
  made essentially to make them work as runners in GitHub actions. This one is
  also available in [GHCR as `raku-gha`](https://github.com/jj/docker-raku/pkgs/container/raku-gha).

Additionally, the latest released Raku will be aliased to the `latest` tag.

## Source, issues

Available at [this GitHub repo](https://github.com/JJ/docker-raku). Raise your
issues, or offer your help there.


