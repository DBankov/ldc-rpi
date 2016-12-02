if [[ " $* " == *" help "* ]]
then
  echo 'Sample usage: bootstrap-install.ldc.sh [cmake-src|cmake-apt-get] [apt-get] [sdl2-apt-get] [ldc0] [ldc-git] [ldc-git-build]'
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



#### apt-get start ####
if [[ " $* " == *" apt-get "* ]]
then
  set -ex
  echo 'Installing various prerequisites via apt-get...'
  sudo apt-get install -y llvm-3.7-dev libconfig++-dev libcurl4-gnutls-dev libedit-dev zlib1g-dev libssl-dev libevent-dev
  echo 'llvm-3.7-dev, libconfig++-dev, libcurl4-gnutls-dev, libedit-dev and zlib1g-dev installed successfully!'
  set +ex
else
  echo 'Skipped installing prerequisites via apt-get.';
fi
#### apt-get end ####


#### libSDL2 start ####
if [[ " $* " == *" sdl2-apt-get "* ]]
then
  set -ex
  echo 'Installing libsdl2-dev via apt-get...'
  sudo apt-get install -y libsdl2-dev
  echo 'libsdl2-dev installed successfully!'
  set +ex
else
  echo 'Skipped installing libsdl2 via apt-get.';
fi
#### libSDL2 end ####


#### LDC-1.1.0-beta3 start ####
if [[ " $* " == *" ldc0 "* ]]
then
  set -ex
  echo 'Downloading and extracting LDC-1.1.0-beta3 and dub...'
  wget https://github.com/ldc-developers/ldc/releases/download/v1.1.0-beta3/ldc2-1.1.0-beta3-linux-armv7hf.tar.xz
  tar xf ldc2-1.1.0-beta3-linux-armv7hf.tar.xz
  sudo cp ldc2-1.1.0-beta3-linux-arm/bin/dub /usr/bin
  echo 'LDC-1.1.0-beta3 downloaded successfully!'
  dub --version
  echo 'DUB installed successfully!'
  set +ex
else
  echo 'Skipped download LDC-1.1.0-beta and dub.';
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


if [[ " $* " == *" ldc-git-build "* ]]
then
  set -ex
  cd ldc-git
  mkdir build && cd build
  cmake .. -DD_COMPILER=`realpath ../../ldc2-1.1.0-beta3-linux-arm/bin/ldmd2`
  make -j1
  sudo make install
  set +ex
else
  echo 'Skipped build of LDC-git.';
fi
#### LDC-git end ####
