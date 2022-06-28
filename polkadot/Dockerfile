FROM    ubuntu:18.04 as build

ENV     DEBIAN_FRONTEND=noninteractive \
        TZ=Etx/UTC

RUN     apt-get update -qq && apt-get install -y \
        git \
        cmake \
        g++ \
        pkg-config \
        libssl-dev \
        curl \
        llvm \
        clang \
        binutils-dev \
        libcurl4-openssl-dev \
        zlib1g-dev \
        libdw-dev  \
        libiberty-dev  \
        gcc  \
        python \
        docker.io  \
        protobuf-compiler  \
        cargo \
        awscli \
        build-essential \
        libclang-dev \ 
        libssl-dev \
        && rm -rf /var/lib/apt/lists/*

ENV     RUSTUP_HOME=/usr/local/rustup \
        CARGO_HOME=/usr/local/cargo \
        PATH=/usr/local/cargo/bin:$PATH

RUN     curl https://sh.rustup.rs -sSf | \
        sh -s -- -y --no-modify-path --default-toolchain none

VOLUME  [ /polkadot ]

WORKDIR /polkadot

COPY . /polkadot

RUN /polkadot/scripts/init.sh && cargo build --release

RUN cp /polkadot/target/release/polkadot /tmp/polkadot


# Actual image
FROM    ubuntu:18.04

EXPOSE  9933 30333 30334

RUN     apt-get update -qq && apt-get install -y \
        libssl-dev ca-certificates \
        wget \
        && rm -rf /var/lib/apt/lists/*

COPY    --from=build /tmp/polkadot /usr/local/bin/

ENTRYPOINT [ "polkadot"]

CMD [ "--chain=kusama" ]





