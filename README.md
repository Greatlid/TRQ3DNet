# TRQ3D
The implementation of paper "TRQ3DNet: A 3D Quasi-Recurrent and Transformer
Based Network for Hyperspectral Image Denoising"

### 1. Preparing your training/testing datasets
Download ICVL hyperspectral image database into '''data''' folder.

The train-validation-test split can be found in ```train_fns.txt``` , ```validation_fns_*.txt``` and  ```test_fns_*.txt```. (Note we split the 101 testing data into two parts for Gaussian and complex denoising respectively.)

Create your training dataset by ``hsi_data_preprocess.py```

Create your validation and testing dataset by ```matlab/HSIData.m``` and split the data by ```hsi_train_val_test_split.py```

### 2. Testing with pretrained models
* [Blind Gaussian noise removal]:   
```python hsi_test.py -a trq3d -p gauss -r -rp checkpoints/trq3d/gauss/model_epoch_50_118454.pth```

* [Mixture noise removal]:  
```python hsi_test.py -a trq3d -p complex -r -rp checkpoints/trq3d/complex/model_epoch_100_159904.pth```

### 3. Training from scratch
* Training a blind Gaussian model firstly by  
```python hsi_denoising_gauss.py -a trq3d -p gauss --dataroot (your own dataroot)```

* Using the pretrained Gaussian model as initialization to train a complex model:  
```python hsi_denoising_complex.py -a trq3d -p complex --dataroot (your own dataroot) -r -rp checkpoints/trq3d/gauss/model_epoch_50_118454.pth```
