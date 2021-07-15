mxnet: 1.5.0 (cuda: 9.0)
BS: 
gluonnlp: 0.8.3


1) install mxnet from pip
 pip install --user mxnet-cu90==1.5.0 # will appear at ~/.local/lib/python2.7/site-packages/mxnet

2) install mxnet from source: 
 pre-requisite: 
      sudo apt install libopencv-dev -y
      sudo apt-get install libatlas-base-dev  -y
      install nvidia-driver-460 , install cuda-9.0
      sudo vim /etc/ld.so.conf #add path: cuda-9.0/lib64
      sudo ldconfig
 cd mxnet/
 make
 sudo python -m pip install --user -e ./python  
#Note that the -e flag is optional. It is equivalent to --editable 
#and means that if you edit the source files, these changes will be reflected in the package installed
# --user means installing to your own account python lib space

3) install gluonnlp from source:
 cd gluonnlp
 sudo pip install --user -e .
 (or sudo python setup.py install --user)

4) modify Mxnet python lib:
     modify Mxnet python code in ~/incubator-mxnet/python
     # mxnet python lib in ~/.local/lib/python2.7  is link to  ~/incubator-mxnet/python. So dont need to do python install again

5) modify Mxnet c++ lib:
     modify Mxnet c++ code in ~/incubator-mxnet/src
     make again so to update libmxnet.so in ~/incubator-mxnet/lib, which is used by mxnet python lib in ~/incubator-mxnet/python

6) install BS from source
  pre-requisite: 
    sudo pip install bayesian-optimization==1.0.1 six
  cd bytescheduler/
  vim setup.py to add MXNET_ROOT path
  sudo pip install --user -e .
  (or sudo python setup.py install --user)
  One problem: cannot find **.so, this is because LD_LIBRARY_PATH in sudo is dofferent
       we need to add lib path to /etc/ld.so.conf then run sudo ldconfig

7) modify BS:
  python -m pip uninstall bytescheduler #uninstall
  change BS python code in ~/Bytescheduler
  sudo python setup.py install --user   # will update BS lib python in ~/.local/lib/python2.7




