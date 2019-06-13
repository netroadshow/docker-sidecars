#!/bin/bash
MONIT_TAG=":latest"
NGINX_TAG=":latest"
ASPNET_COMMAND="docker build -t netroadshow/aspnet -f aspnet/aspnet22.dockerfile aspnet"
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
    exec docker run -it --rm -p 443:443 -p 80:80 --name demo demo
}

shell() {
    exec docker run -it --rm -p 443:443 -p 80:80 --entrypoint "" --name demo demo $1
}

case "$2" in
    jetty)
        DEMO_DIR="jetty"
        DEMO_PATH="jetty/Dockerfile"
        ;;
    aspnet)
        DEMO_PATH="demo/aspnet-demo.dockerfile"
        ;;
    aspnet21)
        ASPNET_COMMAND="docker build -t netroadshow/aspnet -f aspnet/aspnet21.dockerfile aspnet"
        DEMO_PATH="demo/aspnet-demo.dockerfile"
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
