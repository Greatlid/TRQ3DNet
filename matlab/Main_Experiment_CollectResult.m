clc;clear;close all
addpath(genpath('lib'));
path = '..\images\gavyam_0823-0933';
files = dir(path);
hsi = load('..\images\gavyam_0823-0933\gavyam_0823-0933.mat');
hsi = hsi.gt;
res = cell(length(files)-2, 2);
for i = 3:length(files)
    imgpath = fullfile(path, files(i).name);
    R_hsi = load(imgpath);
    if isfield(R_hsi, 'R_hsi')
       R_hsi = R_hsi.R_hsi; 
    else
        continue;
    end
    [psnr, ssim, fsim, ergas, sam] = MSIQA(hsi*255, R_hs*255i);
    res{i-2, 1} = files(i).name;
    res{i-2, 2} = psnr;
end
