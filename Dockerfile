FROM ubuntu:noble

ARG NON_PRIVILEGED_USER=yolo

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        git \
        lsb-release \
        make \
        sudo \
        curl 

RUN useradd -m ${NON_PRIVILEGED_USER} && \
    echo "${NON_PRIVILEGED_USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${NON_PRIVILEGED_USER}


USER ${NON_PRIVILEGED_USER}

WORKDIR /home/${NON_PRIVILEGED_USER}

COPY debs debs
COPY Makefile .

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
