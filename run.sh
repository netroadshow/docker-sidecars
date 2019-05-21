#!/bin/bash
build_debian() {
    docker build -t netroadshow/monit monit
    docker build -t netroadshow/nginx-sidecar nginx
    docker build -t validate test
}

build_alpine() {
    docker build -t netroadshow/monit:alpine -f monit/alpine.dockerfile monit
    docker build -t netroadshow/nginx-sidecar:alpine -f nginx/alpine.dockerfile nginx
    docker build -t validate -f test/validate-alpine.dockerfile .
}

run() {
    docker run -it --rm -p 80:80 -p 443:443 validate
}

case "$1" in
    build)
        build_debian
        ;;
    build-alpine)
        build_alpine
        ;;
    run)
        build_debian
        run
        ;;
    run-alpine)
        build_alpine
        run
        ;;
    *)
        echo "Usage: {build|build-alpine|run|run-alpine}" >&2
        ;;
esac
