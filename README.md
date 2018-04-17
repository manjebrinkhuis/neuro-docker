# neuro-docker

A collection of dockerfiles to make running neuroimaging tools easier. Mainly for personal reference, but perhaps useful to others.

Each folder contains a dockerfile and a launcher script.

To run `fslview`, build the image with

    cd dockerfiles/fslview
    docker build -t neuro-docker/fslview .

And run in bash

    ./run_fslview.sh

Make sure to mount the right volumes, so you can access your files. To do so, change the following line in `run_fslview.sh`

    -v /mnt/data:/data

to

    -v /path/to/your/data:/data

## neuro-jupyterlab

WIP
