#!/bin/bash

sudo nerdctl \
  --address /run/k3s/containerd/containerd.sock \
  --namespace k8s.io \
  run \
    --privileged \
    --volume $HOME:$HOME \
    --user 0:0 \
    -it \
      cli-tool-docker sh -c \
        "useradd \
	  --uid 503 \
	  --gid 1000 \
	  --home $HOME \
	  --shell /usr/bin/fish \
	  $USER && \
	su - $USER" 
