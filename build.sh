#!/bin/bash
docker build -t monitor monit
docker build -t nginx-sidecar nginx
