FROM neurodebian:xenial-non-free
MAINTAINER manjebrinkhuis@gmail.com

USER root

# Create user and setup directories
RUN useradd -m -s /bin/bash neuro

RUN mkdir /home/neuro/.jupyter \
  && chown -R neuro:neuro /home/neuro

ADD jupyter_notebook_config.py \
  /home/neuro/.jupyter/jupyter_notebook_config.py

RUN mkdir /data \
  && chown -R neuro:neuro /data

# Dependencies
RUN apt-get update && apt-get -yq dist-upgrade \
  && apt-get install -yq --no-install-recommends \
    gnupg \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libglu1-mesa \
    libxi-dev \
    libxmu-dev \
    libglu1-mesa-dev \
    libjpeg62-dev

# Lanuage
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen

ENV LC_ALL=en_US.UTF-8 \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8

# FSL
RUN apt-get install -y fsl-core fslview
ENV FSLDIR /usr/share/fsl/5.0
RUN bash ${FSLDIR}/etc/fslconf/fsl.sh
RUN PATH=${FSLDIR}/bin:${PATH}
RUN export FSLDIR PATH

# Freesurfer -- requires freesurfer
# folder to be mounted to /opt/freesurfer
RUN mkdir /opt/freesurfer \
  && echo "FREESURFER_HOME=/opt/freesurfer" >> /home/neuro/.bashrc \
  && echo 'source $FREESURFER_HOME/SetUpFreeSurfer.sh' >> /home/neuro/.bashrc

USER neuro

# Miniconda
ENV CONDA_FNAME=Miniconda3-latest-Linux-x86_64.sh \
    CONDA_URL=https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    CONDA_PATH=/home/neuro/conda
ENV PATH=${CONDA_PATH}/bin:${PATH}

RUN wget ${CONDA_URL} -P /tmp/ \
  && bash /tmp/${CONDA_FNAME} -b -p ${CONDA_PATH} \
  && ${CONDA_PATH}/bin/conda config --add channels conda-forge \
  && ${CONDA_PATH}/bin/conda clean -tipsy

# Jupyterlab + environment
RUN ${CONDA_PATH}/bin/conda install -y jupyterlab \
  && ${CONDA_PATH}/bin/conda install -y -c r r r-essentials \
  && ${CONDA_PATH}/bin/conda create -y -n neuro \
    python=3 \
    pandas \
    numpy \
    scipy \
    nipype \
    nibabel \
    ipykernel \
  && ${CONDA_PATH}/envs/neuro/bin/python -m ipykernel \
    install --user --name neuro

# Finish
USER root
EXPOSE 8888
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER neuro
ENV SHELL=/bin/bash \
  USER=neuro
  
ENTRYPOINT ["/bin/bash"]
