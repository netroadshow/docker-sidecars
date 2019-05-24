#!/bin/bash
MONIT_TAG=":latest"
NGINX_TAG=":latest"
ASPNET_COMMAND="docker build -t netroadshow/aspnet aspnet"
FLUENT_COMMAND="docker build -t netroadshow/fluent fluent"
DEMO_DIR="demo"
DEMO_PATH="demo/nginx-debian-demo.dockerfile"
SHELL_COMMAND="/bin/bash"

check() {
    $1 || { echo "Failed!" >&2 ; exit 1; }
}

build() {
    check "docker build -t netroadshow/monit${MONIT_TAG} monit"
    check "$FLUENT_COMMAND"
    check "docker build -t netroadshow/nginx-sidecar${NGINX_TAG} nginx"
    check "$ASPNET_COMMAND"
    check "docker build -t demo -f $DEMO_PATH $DEMO_DIR"
}

run() {
    exec docker run -it --rm -p 443:443 --name demo demo
}

shell() {
    exec docker run -it --rm -p 443:443 --entrypoint "" --name demo demo $1
}

case "$2" in
    alpine)
        MONIT_TAG=":alpine -f monit/alpine.dockerfile"
        NGINX_TAG=":alpine -f nginx/alpine.dockerfile"
        ASPNET_COMMAND=""
        FLUENT_COMMAND=""
        DEMO_PATH="demo/nginx-alpine-demo.dockerfile"
        SHELL_COMMAND="/bin/sh"
        ;;
    jetty)
        MONIT_TAG=":alpine -f monit/alpine.dockerfile"
        NGINX_TAG=":alpine -f nginx/alpine.dockerfile"
        ASPNET_COMMAND=""
        FLUENT_COMMAND=""
        DEMO_DIR="jetty"
        DEMO_PATH="jetty/Dockerfile"
        SHELL_COMMAND="/bin/sh"
        ;;
    aspnet)
        DEMO_PATH="demo/aspnet-demo.dockerfile"
        ;;
    aspnet21)
        ASPNET_COMMAND="docker build -t netroadshow/aspnet aspnet"
        ;;
esac

case "$1" in
    build)
        build
        ;;
    run)
        build
        run
        ;;
    shell)
        build
        shell $SHELL_COMMAND
        ;;
    *)
        echo "Usage: ./run.sh { build | run | shell } [{ aspnet | alpine }]" >&2
        exit 1
        ;;
esac

exit 0
