FROM alpine:latest as base

ARG RAKU_RELEASE=2021.10

# Set up as root
ENV PKGS="git make gcc musl-dev perl linux-headers bash"

RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS


RUN git clone --depth 1 --branch ${RAKU_RELEASE} https://github.com/MoarVM/MoarVM.git \
    && cd MoarVM \
    && perl Configure.pl --prefix /usr \
    && make --print-data-base \
    && make install\
    && echo $PWD \
    && cd .. \
    && git clone --depth 1 --branch ${RAKU_RELEASE} git://github.com/Raku/nqp.git \
    && cd nqp \
    && perl Configure.pl --backends=moar --prefix /usr \
    && make install \
    && cd .. \
    && git clone --depth 1 --branch ${RAKU_RELEASE} https://github.com/rakudo/rakudo.git \
    && cd rakudo \
    && perl Configure.pl --backends=moar --prefix /usr \
    && make install \
    && ls /usr/share/nqp/

FROM alpine:latest

LABEL version="0.1.0" maintainer="JJMerelo@GMail.com"

COPY --from=base /usr/lib/libmoar.so /usr/lib
COPY --from=base /usr/share/nqp/  /usr/share/nqp
COPY --from=base /usr/share/perl6/  /usr/share/perl6
COPY --from=base /usr/bin/moar /usr/bin/nqp  /usr/bin/raku /usr/bin/perl6 /usr/bin/rakudo  /usr/bin/

RUN addgroup -S raku  && adduser -S raku -G raku --home /home/raku

USER raku
WORKDIR /home/raku

ENTRYPOINT ["raku"]
