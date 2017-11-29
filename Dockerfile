FROM ubuntu:16.04

RUN dpkg --add-architecture i386 && apt-get update && apt-get install --yes \
  apt-transport-https \
  autoconf \
  automake \
  autopoint \
  bc \
  bison \
  ccache \
  cmake \
  curl \
  flex \
  g++ \
  gawk \
  gcc \
  gettext \
  git \
  gperf \
  groff \
  intltool \
  kmod \
  lib32z1 \
  libc6-i386 \
  liblzo2-dev \
  libpython2.7-dev:i386 \
  libstdc++6:i386 \
  libtool \
  libxml2-utils \
  lua5.3 \
  make \
  mtd-utils \
  net-tools \
  nodejs \
  pkg-config \
  python-m2crypto \
  scons \
  texinfo \
  u-boot-tools \
  uuid-dev \
  xutils-dev \
  zip \
  zlib1g-dev \
  && rm --recursive --force /var/lib/apt/lists/*

# lua: Scripts expect to run via "lua" command
# nodejs: ubuntu repo version (non-latest) does not install "node" executable
RUN ln -sf /usr/bin/lua5.3 /usr/bin/lua \
  && ln -sf /usr/bin/nodejs /usr/bin/node

RUN git clone --depth=1 --progress --verbose \
  --branch binaries https://github.com/wsbu/toolchain-ram.git /binaries \
  && yes | /binaries/eldk/install -d /opt/eldk/4.2 arm \
  && ln -sf 4.2/arm /opt/eldk/arm \
  && rm -rf /binaries

# Lots of things complain if we are homeless
ENV HOME /home/captain
RUN mkdir --parents ${HOME}/.ccache && chmod -R 777 ${HOME}

#wget -O- https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-src.tar.bz2
#tar -xf gcc-arm-none-eabi-5_4-2016q3-20160926-src.tar.bz2
#cd gcc-arm-none-eabi-5_4-2016q3-20160926/src
#for f in *; do tar -xf "$f"; done
#cd ..
#./build-prerequisites.sh --skip_steps=mingw32
#./build-toolchain.sh --skip_steps=mingw32,manual
Errors...
checking whether to use python... yes
checking for python... /usr/bin/python
checking for python2.7... no
configure: error: python is missing or unusable
Makefile:8724: recipe for target 'configure-gdb' failed
make[1]: *** [configure-gdb] Error 1
make[1]: Leaving directory '/mnt/gcc-arm-none-eabi-5_4-2016q3-20160926/build-native/gdb'
Makefile:844: recipe for target 'all' failed
make: *** [all] Error 2
