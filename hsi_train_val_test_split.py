import os
import shutil
os.makedirs('./data/icvl_512_gauss_validation', exist_ok=True)
os.makedirs('./data/icvl_512_complex_validation', exist_ok=True)
os.makedirs('./data/temp', exist_ok=True)

with open('validation_fns_gauss.txt', 'r') as f:
    line = f.read()
    val_fns = line.split('\n')
    val_fns = val_fns[:-1]
with open('test_fns_gauss.txt', 'r') as f:
    line = f.read()
    test_fns = line.split('\n')
dataset = ['icvl_512_30', 'icvl_512_50', 'icvl_512_70', 'icvl_512_blind']
for ds in dataset:
    for fn in val_fns:
        os.makedirs(f'./data/temp/{ds}', exist_ok=True)
        shutil.move(f'./data/{ ds }/{ fn }', f'./data/temp/{ ds }/{ fn }')

for fn in val_fns[:2]:
    shutil.copy(f'./data/temp/icvl_512_30/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    # shutil.copy(f'./data/temp/icvl_512_noniid/{fn}', f'./data/icvl_512_complex_validation/{fn}')
for fn in val_fns[2:4]:
    shutil.copy(f'./data/temp/icvl_512_50/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    # shutil.copy(f'./data/temp/icvl_512_stripe/{fn}', f'./data/icvl_512_complex_validation/{fn}')
for fn in val_fns[4:6]:
    shutil.copy(f'./data/temp/icvl_512_70/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    # shutil.copy(f'./data/temp/icvl_512_deadline/{fn}', f'./data/icvl_512_complex_validation/{fn}')
for fn in val_fns[6:8]:
    # shutil.copy(f'./data/temp/icvl_512_blind/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    shutil.copy(f'./data/temp/icvl_512_impulse/{fn}', f'./data/icvl_512_complex_validation/{fn}')
for fn in val_fns[8:10]:
    # shutil.copy(f'./data/temp/icvl_512_blind/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    shutil.copy(f'./data/temp/icvl_512_mixture/{fn}', f'./data/icvl_512_complex_validation/{fn}')

with open('validation_fns_complex.txt', 'r') as f:
    line = f.read()
    val_fns = line.split('\n')
    val_fns = val_fns[:-1]
with open('test_fns_complex.txt', 'r') as f:
    line = f.read()
    test_fns = line.split('\n')
dataset = ['icvl_512_noniid', 'icvl_512_stripe', 'icvl_512_deadline', 'icvl_512_impulse', 'icvl_512_mixture']
for ds in dataset:
    for fn in val_fns:
        os.makedirs(f'./data/temp/{ds}', exist_ok=True)
        shutil.move(f'./data/{ ds }/{ fn }', f'./data/temp/{ ds }/{ fn }')

for fn in val_fns[:2]:
    # shutil.copy(f'./data/temp/icvl_512_30/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    shutil.copy(f'./data/temp/icvl_512_noniid/{fn}', f'./data/icvl_512_complex_validation/{fn}')
for fn in val_fns[2:4]:
    # shutil.copy(f'./data/temp/icvl_512_50/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    shutil.copy(f'./data/temp/icvl_512_stripe/{fn}', f'./data/icvl_512_complex_validation/{fn}')
for fn in val_fns[4:6]:
    # shutil.copy(f'./data/temp/icvl_512_70/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    shutil.copy(f'./data/temp/icvl_512_deadline/{fn}', f'./data/icvl_512_complex_validation/{fn}')
for fn in val_fns[6:8]:
    shutil.copy(f'./data/temp/icvl_512_blind/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    # shutil.copy(f'./data/temp/icvl_512_impulse/{fn}', f'./data/icvl_512_complex_validation/{fn}')
for fn in val_fns[8:10]:
    shutil.copy(f'./data/temp/icvl_512_blind/{ fn }', f'./data/icvl_512_gauss_validation/{ fn }')
    # shutil.copy(f'./data/temp/icvl_512_mixture/{fn}', f'./data/icvl_512_complex_validation/{fn}')



