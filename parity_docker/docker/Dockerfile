FROM ubuntu:18.04

WORKDIR /build
ARG git_branch=feature/instant_seal_consensus

# install tools and dependencies
ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

RUN apt-get install -y --force-yes --no-install-recommends \
        curl git make g++ wget file ca-certificates \
        libudev-dev cmake\
        && apt-get clean

# install rustup
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# rustup directory
ENV PATH /root/.cargo/bin:$PATH

# show backtraces
ENV RUST_BACKTRACE 1

# show tools
RUN rustc -vV && \
    cargo -V 

# build parity
RUN git clone https://github.com/TrueLevelSA/parity-ethereum.git parity

RUN cd parity && \
    git checkout $git_branch && \
    mkdir -p .cargo && \
    cargo build --release --verbose 

RUN mv /build/parity/target/release/parity /usr/local/bin

# RPC port
EXPOSE 8545

# WS port
EXPOSE 8546

# node discovery/connexion
EXPOSE 30303/tcp
EXPOSE 30303/udp

WORKDIR /run

COPY ./wait_for_signal.sh ./node.pwd ./node.toml ./demo-spec.json ./

# TODO: change user

ENTRYPOINT [ "/bin/bash",  "./wait_for_signal.sh"]
