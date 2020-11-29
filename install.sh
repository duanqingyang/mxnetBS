# install cuda, bytescheduler and mxnet

#FROM nvidia/cuda:9.0-cudnn7-devel
MY_PATH="/users/duanqing"

export MXNET_ROOT=/users/duanqing/incubator-mxnet

export USE_BYTESCHEDULER=1
export BYTESCHEDULER_WITH_MXNET=1
export BYTESCHEDULER_WITHOUT_PYTORCH=1

export LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"



cd $MY_PATH

# Install dev tools
sudo apt-get update && sudo apt-get install -y iputils-ping && sudo apt-get install -y apt-utils &&  sudo apt-get install -y net-tools
    # duanqingyang adding dependencies 
sudo apt-get install -y vim git python-dev build-essential &&\
    sudo apt-get install -y wget && sudo wget https://bootstrap.pypa.io/get-pip.py && sudo python get-pip.py

# Install gcc 4.9
mkdir -p "$MY_PATH/gcc/" && cd "$MY_PATH/gcc/" &&\
    wget http://launchpadlibrarian.net/247707088/libmpfr4_3.1.4-1_amd64.deb &&\
    wget http://launchpadlibrarian.net/253728424/libasan1_4.9.3-13ubuntu2_amd64.deb &&\
    wget http://launchpadlibrarian.net/253728426/libgcc-4.9-dev_4.9.3-13ubuntu2_amd64.deb &&\
    wget http://launchpadlibrarian.net/253728314/gcc-4.9-base_4.9.3-13ubuntu2_amd64.deb &&\
    wget http://launchpadlibrarian.net/253728399/cpp-4.9_4.9.3-13ubuntu2_amd64.deb &&\
    wget http://launchpadlibrarian.net/253728404/gcc-4.9_4.9.3-13ubuntu2_amd64.deb &&\
    wget http://launchpadlibrarian.net/253728432/libstdc++-4.9-dev_4.9.3-13ubuntu2_amd64.deb &&\
    wget http://launchpadlibrarian.net/253728401/g++-4.9_4.9.3-13ubuntu2_amd64.deb

cd "$MY_PATH/gcc/" &&\
    sudo dpkg -i gcc-4.9-base_4.9.3-13ubuntu2_amd64.deb &&\
    sudo dpkg -i libmpfr4_3.1.4-1_amd64.deb &&\
    sudo dpkg -i libasan1_4.9.3-13ubuntu2_amd64.deb &&\
    sudo dpkg -i libgcc-4.9-dev_4.9.3-13ubuntu2_amd64.deb &&\
    sudo dpkg -i cpp-4.9_4.9.3-13ubuntu2_amd64.deb &&\
    sudo dpkg -i gcc-4.9_4.9.3-13ubuntu2_amd64.deb &&\
    sudo dpkg -i libstdc++-4.9-dev_4.9.3-13ubuntu2_amd64.deb &&\
    sudo dpkg -i g++-4.9_4.9.3-13ubuntu2_amd64.deb

# Pin GCC to 4.9 (priority 200) to compile correctly against MXNet.
sudo update-alternatives --install /usr/bin/gcc gcc $(readlink -f $(which gcc)) 100 && \
    sudo update-alternatives --install /usr/bin/x86_64-linux-gnu-gcc x86_64-linux-gnu-gcc $(readlink -f $(which gcc)) 100 && \
    sudo update-alternatives --install /usr/bin/g++ g++ $(readlink -f $(which g++)) 100 && \
    sudo update-alternatives --install /usr/bin/x86_64-linux-gnu-g++ x86_64-linux-gnu-g++ $(readlink -f $(which g++)) 100

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 200 && \
    sudo update-alternatives --install /usr/bin/x86_64-linux-gnu-gcc x86_64-linux-gnu-gcc /usr/bin/gcc-4.9 200 && \
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.9 200 && \
    sudo update-alternatives --install /usr/bin/x86_64-linux-gnu-g++ x86_64-linux-gnu-g++ /usr/bin/g++-4.9 200

pip install mxnet-cu90==1.5.0

# Clone MXNet as ByteScheduler compilation needs header files
git clone --recursive --branch v1.5.x https://github.com/apache/incubator-mxnet.git
cd incubator-mxnet && git reset --hard 75a9e187d00a8b7ebc71412a02ed0e3ae489d91f

# Install ByteScheduler
pip install bayesian-optimization==1.0.1 six
cd /usr/local/cuda/lib64 && ln -s stubs/libcuda.so libcuda.so.1
git clone --branch bytescheduler --recursive https://github.com/bytedance/byteps.git && \
    cd byteps/bytescheduler && python setup.py install
sudo rm -f /usr/local/cuda/lib64/libcuda.so.1 && \
    sudo ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/libcuda.so.1 
    # duanqingyang adding to fix mxnet running bug 

# Examples
cd "$MY_PATH/byteps/bytescheduler/examples/mxnet-image-classification"
