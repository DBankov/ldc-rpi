set -ex

mkdir d-rpi && cd d-rpi
wget https://github.com/ldc-developers/ldc/releases/download/v1.1.0-beta3/ldc2-1.1.0-beta3-linux-armv7hf.tar.xz
tar -xf ldc2-1.1.0-beta3-linux-armv7hf.tar.xz -C ldc2-1.1.0-beta3
git config --global url."https://github".insteadOf git://github
git clone --recursive https://github.com/ldc-developers/ldc.git ldc-git
sudo apt install llvm-3.8-dev
