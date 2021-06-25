install mxnet from source: 
1) pre-requisite: 
     sudo apt install libopencv-dev
      sudo apt-get install libatlas-base-dev
2) cd mxnet/
3) make
4) python -m pip install --user -e ./python  
#Note that the -e flag is optional. It is equivalent to --editable 
#and means that if you edit the source files, these changes will be reflected in the package installed


modify BS:
1) change BS python code in ~/Bytescheduler
2) sudo python setup.py install --user   # will update BS lib python in ~/.local/lib/python2.7


modify Mxnet python lib:
1) modify Mxnet python code in ~/incubator-mxnet/python
# mxnet python lib in ~/.local/lib/python2.7  is link to  ~/incubator-mxnet/python. So dont need to do python install again

modify Mxnet c++ lib:
1) modify Mxnet c++ code in ~/incubator-mxnet/src
2) make again so to update libmxnet.so in ~/incubator-mxnet/lib, which is used by mxnet python lib in ~/incubator-mxnet/python

