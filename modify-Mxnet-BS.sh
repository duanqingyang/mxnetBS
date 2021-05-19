modify BS:
1) change BS python code in ~/Bytescheduler
2) sudo python setup.py install --user   # will update BS lib python in ~/.local/lib/python2.7


modify Mxnet python lib:
1) modify Mxnet python code in ~/incubator-mxnet/python
# mxnet python lib in ~/.local/lib/python2.7  is link to  ~/incubator-mxnet/python. So dont need to do python install again

modify Mxnet c++ lib:
1) modify Mxnet c++ code in ~/incubator-mxnet/src
2) make again so to update libmxnet.so in ~/incubator-mxnet/lib, which is used by mxnet python lib in ~/incubator-mxnet/python

