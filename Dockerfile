FROM alpine:latest

ARG VER="2020.12"
LABEL version="3.1.0" maintainer="JJMerelo@GMail.com" rakuversion=$VER

# Set up as root
ENV PKGS="git make gcc musl-dev" \
    PKGS_TMP="perl linux-headers bash"

RUN apk update && apk upgrade \
    && apk add --no-cache $PKGS $PKGS_TMP


RUN git clone https://github.com/MoarVM/MoarVM.git \
    && cd MoarVM \ 
    && perl Configure.pl && make

RUN apk del $PKGS_TMP

ENTRYPOINT ["moarvm"]
