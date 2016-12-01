
mkdir d-rpi && cd d-rpi

#### CMake start ####
if [[ " $* " == *" -cmake "* ]]
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
  echo 'CMake built successfully!';
else
  echo 'Skipping CMake.';
fi
#### CMake end ####



#### LLVM start ####
if [[ " $* " == *" -llvm "* ]]
then
  set -ex
  echo 'Installing LLVM...'
  sudo apt install llvm-3.7-dev
  echo 'LLVM installed successfully!'
  set +ex
else
  echo 'Skipping LLVM.';
fi
#### LLVM end ####



#### LDC-1.1.0-beta3 start ####
if [[ " $* " == *" -ldc0 "* ]]
then
  set -ex
  echo 'Downloading and extracting LDC-1.1.0-beta3...'
  wget https://github.com/ldc-developers/ldc/releases/download/v1.1.0-beta3/ldc2-1.1.0-beta3-linux-armv7hf.tar.xz
  tar -xf ldc2-1.1.0-beta3-linux-armv7hf.tar.xz -C ldc2-1.1.0-beta3
  echo 'LDC-1.1.0-beta3 downloaded successfully!'
  set +ex
else
  echo 'Skipping LDC-1.1.0-beta.';
fi
#### LDC-1.1.0-beta3 end ####



#### LDC-git start ####
set -ex
echo 'Cloning LDC git'
git config --global url."https://github".insteadOf git://github
git clone --recursive https://github.com/ldc-developers/ldc.git ldc-git
echo 'LDC-git cloned successfully!'
set +ex
#### LDC-git end ####
