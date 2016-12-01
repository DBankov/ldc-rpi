if [[ " $* " == *" help "* ]]
then
  echo 'Sample usage: bootstrap-install.ldc.sh [cmake-src|cmake-apt-get] [apt-get] [ldc0] [ldc-git]'
fi

mkdir -p d-rpi && cd d-rpi

#### CMake start ####
if [[ " $* " == *" cmake-src "* ]]
then
  set -ex
  echo 'Downloading CMake...';
  wget https://cmake.org/files/v3.7/cmake-3.7.1.tar.gz;
  tar xf cmake-3.7.1.tar.gz;
  cd cmake-3.7.1;
  echo 'Building CMake...';
  ./configure;
  make;
  sudo make install;
  set +ex
  echo 'CMake installed successfully!';
elif [[ " $* " == *" cmake-apt-get "* ]]
then
  set -ex
  echo 'Installing cmake via apt-get....';
  sudo apt-get install -y cmake
  set +ex
  echo 'CMake installed successfully!';
else
  echo 'Skipped installing CMake.';
fi
#### CMake end ####



#### LLVM start ####
if [[ " $* " == *" apt-get "* ]]
then
  set -ex
  echo 'Installing various prerequisites via apt-get...'
  sudo apt-get install -y llvm-3.7-dev libconfig++-dev libcurl4-gnutls-dev libedit-dev zlib1g-dev
  echo 'llvm-3.7-dev, libconfig++-dev, libcurl4-gnutls-dev, libedit-dev and zlib1g-dev installed successfully!'
  set +ex
else
  echo 'Skipped installing prerequisites via apt-get.';
fi
#### LLVM end ####



#### LDC-1.1.0-beta3 start ####
if [[ " $* " == *" ldc0 "* ]]
then
  set -ex
  echo 'Downloading and extracting LDC-1.1.0-beta3...'
  wget https://github.com/ldc-developers/ldc/releases/download/v1.1.0-beta3/ldc2-1.1.0-beta3-linux-armv7hf.tar.xz
  tar xf ldc2-1.1.0-beta3-linux-armv7hf.tar.xz
  echo 'LDC-1.1.0-beta3 downloaded successfully!'
  set +ex
else
  echo 'Skipped LDC-1.1.0-beta.';
fi
#### LDC-1.1.0-beta3 end ####



#### LDC-git start ####
if [[ " $* " == *" ldc-git "* ]]
then
  set -ex
  echo 'Cloning LDC git'
  git config --global url."https://github".insteadOf git://github
  git clone --recursive https://github.com/ldc-developers/ldc.git ldc-git
  echo 'LDC-git cloned successfully!'
  set +ex
else
  echo 'Skipping cloning of LDC-git.';
fi


set -ex
cd ldc-git
mkdir build && cd build
cmake .. -DD_COMPILER=`realpath ../../ldc2-1.1.0-beta3-linux-arm/bin/ldmd2`
make -j1
sudo make install
set +ex
#### LDC-git end ####
