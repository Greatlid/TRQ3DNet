import argparse
from hsi_setup import Engine, train_options
from utility import *
from torchvision.transforms import Compose
import torch
from torch.utils.data import DataLoader
if __name__ == '__main__':

    """Testing settings"""
    parser = argparse.ArgumentParser(
        description='Hyperspectral Image Denoising')
    opt = train_options(parser)
    opt.no_log = True
    opt.no_ropt = True
    print(opt)

    model_names = opt.resumePath.split('/')[-1].split('.')[0]
    savedir = '/'.join(opt.resumePath.split('/')[:-1]) + '/res_' + model_names

    """Set Random Status"""
    seed_everywhere(opt.seed)

    cuda = not opt.no_cuda
    opt.no_log = True

    """Setup Engine"""
    engine = Engine(opt)
    print('model params: %.2f' % (sum([t.nelement() for t in engine.net.parameters()]) / 10 ** 6))

    """Eval Testing Datasets"""
    basefolder = './data'
    dataset = ['icvl_512_30', 'icvl_512_50', 'icvl_512_70', 'icvl_512_blind', 'icvl_512_noniid',
               'icvl_512_stripe', 'icvl_512_deadline', 'icvl_512_impulse', 'icvl_512_mixture']
    # dataset = ['CAVE_mixture']
    # dataset = ['PaviaU_mixture_256']

    for data in dataset:
        print('testing %s..................' % data)
        datadir = os.path.join(basefolder, data)
        mat_dataset = MatDataFromFolder(datadir, size=None)
        if engine.net.use_2dconv:
            mat_transform = Compose([
                LoadMatHSI(input_key='input', gt_key='gt', transform=lambda x:x), # for validation
            ])
        else:
            mat_transform = Compose([
                LoadMatHSI(input_key='input', gt_key='gt', transform=lambda x:x[:,...][None]), # for validation
            ])
        mat_dataset = TransformDataset(mat_dataset, mat_transform)
        mat_loader = DataLoader(
                        mat_dataset,
                        batch_size=1, shuffle=False,
                        num_workers=0, pin_memory=cuda
                    )
        filename = data + '.npy'
        engine.test(mat_loader, savedir=savedir, filename=filename)

