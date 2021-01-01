FROM alpine:latest as base

LABEL version="0.0.1" maintainer="JJMerelo@GMail.com"

# Set up as root
ENV PKGS="git make gcc musl-dev" \
    PKGS_TMP="perl linux-headers bash"

RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP


RUN git clone https://github.com/MoarVM/MoarVM.git \
    && cd MoarVM \
    && perl Configure.pl --prefix /usr \
    && make --print-data-base \
    && make install\
    && echo $PWD \
    && cd .. \
    && git clone git://github.com/Raku/nqp.git \
    && cd nqp \
    && perl Configure.pl --backends=moar --prefix /usr \
    && make install

RUN apk del $PKGS_TMP

FROM alpine:latest

COPY --from=base /usr/bin/moar /bin
COPY --from=base /usr/bin/nqp /bin

ENTRYPOINT ["moarvm"]
