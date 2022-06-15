#/!bin/bash
 
set -e

sudo -s 

# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# . $HOME/.cargo/env

# rustup target add wasm32-unknown-unknown
# rustup --version

# echo export PATH='$HOME/.cargo/bin:$PATH' >> ~/.bashrc

# sudo apt-get update
# sudo apt-get install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker.io protobuf-compiler libssl-dev pkg-config clang llvm cargo awscli libclang-dev llvm-dev git clang curl libssl-dev llvm libudev-dev pkg-config make

# Import the security@parity.io GPG key
sudo gpg --recv-keys --keyserver keyserver.ubuntu.com 9D4B2B6EB8F97156D19669A9FF0812D491B96798
sudo gpg --export 9D4B2B6EB8F97156D19669A9FF0812D491B96798 > /usr/share/keyrings/parity.gpg

Add the Parity repository and update the package index
echo 'deb [signed-by=/usr/share/keyrings/parity.gpg] https://releases.parity.io/deb release main' > /etc/apt/sources.list.d/parity.list
sudo apt-get update

# # Install the `parity-keyring` package - This will ensure the GPG key
# used by APT remains up-to-date
sudo apt-get install parity-keyring

# # Install polkadot
# curl -sL https://github.com/paritytech/polkadot/releases/download/v0.9.22/polkadot -o polkadot
# chmod +x polkadot
# mv /target/release/polkadot /usr/local/bin
sudo apt-get install polkadot

polkadot --name $whoami


