import argparse
import warnings

import torch.utils.data
from utility import *
from hsi_setup import train_options, Engine
from functools import partial
from torchvision.transforms import Compose

if __name__ == "__main__":
    warnings.filterwarnings('ignore')

    """Train Settings"""
    parser = argparse.ArgumentParser(description="Hyperspectral Image Denosing")
    opt = train_options(parser)
    print(f'opt settings: {opt}')

    """Set Random Status"""
    seed_everywhere(opt.seed)

    """Setup Engine"""
    engine = Engine(opt)
    # print(engine.net)
    print('model params: %.2f' % (sum([t.nelement() for t in engine.net.parameters()])/10**6))
    print('==> Preparing data..')
    """Training Data Settings"""

    HSI2Tensor = partial(HSI2Tensor, use_2dconv = engine.get_net().use_2dconv)

    common_transform_1 = lambda x: x
    common_transform_2 = Compose([
        partial(rand_crop, cropx=32, cropy=32),
    ])

    train_transform_1 = Compose([
        AddNoise(50),
        HSI2Tensor()
    ])
    train_transform_2 = Compose([
        AddNoiseBlind([10, 30, 50, 70]),
        HSI2Tensor()
    ])

    target_transform = HSI2Tensor()

    icvl_64_31_TL_1 = make_dataset(
        opt, train_transform_1,
        target_transform, common_transform_1, 16)

    icvl_64_31_TL_2 = make_dataset(
        opt, train_transform_2,
        target_transform, common_transform_2, 64)

    """Validation Data Settings"""
    basefolder = './data/'
    mat_names = ['icvl_512_gauss_validation']

    mat_datasets = [MatDataFromFolder(os.path.join(
        basefolder, name)) for name in mat_names]

    if not engine.get_net().use_2dconv:
        mat_transform = Compose([
            LoadMatHSI(input_key='input', gt_key='gt',
                    transform=lambda x:x[:, ...][None]),
        ])
    else:
        mat_transform = Compose([
            LoadMatHSI(input_key='input', gt_key='gt'),
        ])

    mat_datasets = [TransformDataset(mat_dataset, mat_transform)
                    for mat_dataset in mat_datasets]

    mat_loaders = [torch.utils.data.DataLoader(
        mat_dataset,
        batch_size=1, shuffle=False,
        num_workers=0, pin_memory=opt.no_cuda
    ) for mat_dataset in mat_datasets]

    """Main loop"""
    base_lr = opt.lr
    adjust_learning_rate(engine.optimizer, opt.lr)
    if opt.resume:
        if engine.epoch > 20 and engine.epoch < 30:
            adjust_learning_rate(engine.optimizer, base_lr * 0.1)
        if engine.epoch > 30 and engine.epoch < 35:
            adjust_learning_rate(engine.optimizer, base_lr)
        if engine.epoch > 35 and engine.epoch < 45:
            adjust_learning_rate(engine.optimizer, base_lr * 0.1)
        if engine.epoch > 45:
            adjust_learning_rate(engine.optimizer, base_lr * 0.01)

    epoch_per_save = 10
    rand_status_list = np.random.get_state()[1].tolist()
    while engine.epoch < 50:
        np.random.seed(rand_status_list[engine.epoch % len(rand_status_list)])  # reset seed per epoch, otherwise the noise will be added with a specific pattern
        if engine.epoch == 20:
            adjust_learning_rate(engine.optimizer, base_lr * 0.1)

        if engine.epoch == 30:
            adjust_learning_rate(engine.optimizer, base_lr)

        if engine.epoch == 35:
            adjust_learning_rate(engine.optimizer, base_lr * 0.1)

        if engine.epoch == 45:
            adjust_learning_rate(engine.optimizer, base_lr * 0.01)

        if engine.epoch <= 30:
            engine.train(icvl_64_31_TL_1)
            engine.validate(mat_loaders[0], 'icvl-validate')
        else:
            engine.train(icvl_64_31_TL_2)
            engine.validate(mat_loaders[0], 'icvl-validate')


        print('Latest Result Saving...')
        model_latest_path = os.path.join(engine.basedir, engine.prefix, 'model_latest.pth')
        engine.save_checkpoint(
            model_out_path=model_latest_path
        )

        display_learning_rate(engine.optimizer)
        if engine.epoch % epoch_per_save == 0:
            engine.save_checkpoint()