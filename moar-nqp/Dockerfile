FROM alpine:latest as base

# Set up as root
ENV PKGS="git make gcc musl-dev" \
    PKGS_TMP="perl linux-headers bash"

RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP


RUN git clone https://github.com/MoarVM/MoarVM.git \
    && cd MoarVM \
    && perl Configure.pl --prefix /usr \
    && make install\
    && echo $PWD \
    && cd .. \
    && git clone  git://github.com/Raku/nqp.git \
    && cd nqp \
    && perl Configure.pl --backends=moar --prefix /usr \
    && make install \

FROM alpine:latest

LABEL version="0.0.1" maintainer="JJMerelo@GMail.com"

COPY --from=base /usr/lib/libmoar.so /usr/lib
COPY --from=base /usr/share/nqp/  /usr/share/nqp
COPY --from=base /usr/bin/moar /usr/bin/nqp /usr/bin/

RUN addgroup -S raku  && adduser -S raku -G raku --home /home/raku

USER raku
WORKDIR /home/raku

ENTRYPOINT ["nqp"]
