FROM alpine:latest as base

ARG RAKU_RELEASE=2021.10

ENV PKGS="git make gcc musl-dev perl linux-headers bash"

RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS \
    && git clone --depth 1 --branch ${RAKU_RELEASE} https://github.com/MoarVM/MoarVM.git \
    && cd MoarVM \
    && perl Configure.pl --prefix /usr \
    && make --print-data-base \
    && make install\
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
ARG UID=1000
ARG USER_HOME=/home/raku

LABEL version="0.3.0" maintainer="JJMerelo@GMail.com" raku_release=${RAKU_RELEASE} raku_user_uid=${UID}

COPY --from=base /usr/lib/libmoar.so /usr/lib
COPY --from=base /usr/share/nqp/ /usr/share/nqp
COPY --from=base /usr/share/perl6/ /usr/share/perl6
COPY --from=base /usr/bin/moar /usr/bin/nqp /usr/bin/raku /usr/bin/perl6 /usr/bin/rakudo /usr/bin/

RUN if [[ "$USER_HOME" == *"github"* ]]; then mkdir /github; fi
RUN addgroup -S raku  && adduser -S raku -G raku --uid ${UID} --home ${USER_HOME}

USER raku
WORKDIR ${USER_HOME}

ENTRYPOINT ["raku"]
