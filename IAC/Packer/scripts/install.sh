#/!bin/bash
 
set -e


curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

. $HOME/.cargo/env

rustup target add wasm32-unknown-unknown
rustup --version

echo export PATH='$HOME/.cargo/bin:$PATH' >> ~/.bashrc

sudo apt-get update
sudo apt-get install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config clang llvm cargo awscli libclang-dev llvm-dev

git clone https://github.com/paritytech/polkadot polkadot
cd polkadot
git checkout v0.9.23 
./scripts/init.sh

cargo build --release

sudo mv ./target/release/polkadot /usr/local/bin 

polkadot --name $whoami


