import lmdb
import h5py
import os
from scipy.ndimage import zoom
from scipy.io import loadmat
import numpy as np
from utility import *

def create_train(
        datadir, fns, name, matkey,
        crop_sizes, scales, ksizes, strides,
        load=h5py.File, augment=True,
        seed=2017, type='lmdb'):
    """
    Create Augmented Dataset
    """

    def preprocess(data):
        new_data = []
        # data = minmax_normalize(data)
        # data = np.rot90(data, k=2, axes=(1, 2))  # ICVL
        data = data.astype(np.float32)
        data = minmax_normalize(data.transpose((2,0,1))) # for Remote Sensing
        # Visualize3D(data)
        if crop_sizes is not None:
            data = crop_center(data, crop_sizes[0], crop_sizes[1])

        for i in range(len(scales)):
            if scales[i] != 1:
                temp = zoom(data, zoom=(1, scales[i], scales[i]))
            else:
                temp = data
            temp = Data2Volume(temp, ksizes=ksizes, strides=list(strides[i]))
            new_data.append(temp)
        new_data = np.concatenate(new_data, axis=0)
        if augment:
            for i in range(new_data.shape[0]):
                new_data[i, ...] = data_augmentation(new_data[i, ...])

        return new_data.astype(np.float32)

    np.random.seed(seed)
    scales = list(scales)
    ksizes = list(ksizes)
    assert len(scales) == len(strides)
    # calculate the shape of dataset
    try:
        data = load(datadir + fns[0])[matkey]
        data = np.array(data)
    except:data = loadmat(datadir + fns[0])[matkey]
    data = preprocess(data)
    N = data.shape[0]

    print('data shape: ', data.shape)
    map_size = data.nbytes * len(fns) * 1.2
    print('map size (GB):', map_size / 1024 / 1024 / 1024)
    if type == 'lmdb':
        import ipdb
        ipdb.set_trace()
        if os.path.exists(name + '.db'):
            raise Exception('database already exist!')
        env = lmdb.open(name + '.db', map_size=map_size, writemap=True)
        with env.begin(write=True) as txn:
            # txn is a Transaction object
            k = 0
            for i, fn in enumerate(fns):
                try:
                    X = load(datadir + fn)[matkey]
                except:
                    print('loading', datadir + fn, 'fail')
                    continue
                X = preprocess(X)
                N = X.shape[0]
                import caffe
                for j in range(N):
                    datum = caffe.proto.caffe_pb2.Datum()
                    datum.channels = X.shape[1]
                    datum.height = X.shape[2]
                    datum.width = X.shape[3]
                    datum.data = X[j].tobytes()
                    str_id = '{:08}'.format(k)
                    k += 1
                    txn.put(str_id.encode('ascii'), datum.SerializeToString())
                print('load mat (%d/%d): %s' % (i, len(fns), fn))
    elif type == 'npy':
        if os.path.exists(name + '.npz'):
            raise Exception('database already exist!')
        file_dict = {}
        k = 0
        for i, fn in enumerate(fns):
            print(f'processing { i, fn }')
            try:
                X = load(datadir + fn)[matkey]
            except:
                try: X = loadmat(datadir + fn)[matkey]
                except:
                    print('loading', datadir + fn, 'fail')
                    continue
            X = preprocess(X)
            N = X.shape[0]
            for j in range(N):
                str_id = '{:08}'.format(k)
                file_dict[str_id] = X[j]
                k += 1
        print(f'total { k } patch')
        np.savez(name + '.npz', **file_dict)
    print('done')

def create_icvl64_31(datadir, type):
    print('create icvl64_31...')
    fns = os.listdir(datadir)
    fns = [fn.split('.')[0]+'.mat' for fn in fns]

    create_train(
        datadir, fns, './data/ICVL64_31', 'rad',  # your own dataset address
        crop_sizes=(1024, 1024),
        scales=(1, 0.5, 0.25),
        ksizes=(31, 64, 64),
        strides=[(31, 64, 64), (31, 32, 32), (31, 32, 32)],
        load=h5py.File, augment=True, type=type
    )

def create_pc_102(datadir, type):
    print('create Pavia...')
    fns = os.listdir(datadir)
    fns = [fn.split('.')[0]+'.mat' for fn in fns]

    create_train(
        datadir, fns, './data/pc64_16', 'pavia',  # your own dataset address
        crop_sizes=(640, 1024),
        scales=(1, 0.5, 0.25),
        ksizes=(31, 64, 64),
        strides=[(31, 64, 64), (31, 32, 32), (31, 32, 32)],
        load=h5py.File, augment=True, type=type
    )

def create_cave(datadir, type):
    print('create cave')
    fns = os.listdir(datadir)
    # fns = [fn.split('.')[0]+'.mat' for fn in fns]
    num = len(fns)
    folds = 3
    test_sets = [fns[i:i+num//folds] for i in range(0, num-num//folds, num//folds)]
    for i, fns_test_cur in enumerate(test_sets):
        fns_cur = [fn for fn in fns if not fn in fns_test_cur]
        create_train(
            datadir, fns_cur, f'./data/cave_64_31_{i}', 'imgDouble',  # your own dataset address
            crop_sizes=None,
            scales=(1, 0.5, 0.25),
            ksizes=(31, 64, 64),
            strides=[(31, 64, 64), (31, 32, 32), (31, 32, 32)],
            load=h5py.File, augment=True, type=type
        )

if __name__ == '__main__':
    # datadir = './data/Training/' # your own data address
    # create_icvl64_31(datadir, type = 'npy')
    # datadir = './data/dataset/PaviaCentre/' # your own data address
    # create_pc_102(datadir, type = 'npy')
    datadir = './data/dataset/CAVE/' # your own data address
    create_cave(datadir, type = 'npy')