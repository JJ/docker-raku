# jjmeelo/raku container

This is a bare-bones, lightweight, image that contains the bare
[`raku`](https://raku.org) image, without any frills. It's been created mainly
for lightweightness, and as a base for a family of images.

This is intended mainly as a base image, not so much for direct use. Could be
useful for CI, though.

It includes a non-privileged user, also called `raku`, with its home
directory. Binaries for `raku` are installed in privileged directories, however.

