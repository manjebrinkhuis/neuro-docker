docker run --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v /mnt/data:/data \
    --name fslview \
    neuro-docker/fslview
