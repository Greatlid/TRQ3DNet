clear;clc;close all
addpath(genpath('lib'));
datadir = '../images/Indian_pines';
fns = {'Indian_pines.mat'};
%datadir = '../images/Urban';
%fns = {'Urban.mat'};
savedir = '../images';
methodname = {'None', 'BM4D','TDL', 'ITSReg', 'LLRT','LRMR','LRTV','NMoG','LRTDTV'};
% methodname = {'LLRT'};
% methodname = {'None','LRMR','LRTV','NMoG','LRTDTV'};
for k = 1:length(fns)
    fn = fns{k};
    imgpath = fullfile(datadir, fn);

    img = load(imgpath);
    if isfield(img,'gt')
        hsi = img.gt;
        hsi_noise = img.input;
    elseif isfield(img,'a')
        hsi_noise = img.a;
        hsi_noise = double(hsi_noise);
        hsi_noise = normalized(hsi_noise);
    elseif isfield(img,'indian_pines')
        hsi_noise = img.indian_pines;
        hsi_noise = double(hsi_noise);
        hsi_noise = normalized(hsi_noise);
    end
    if ~isfield(img, 'sigma')
%         sigma_ratio = double(real(NoiseLevel(hsi_noise)));
        sigma_ratio = NoiseLevel(hsi_noise);
    else
        sigma_ratio = img.sigma / 255;
    end
%    if isempty(gcp)
%        parpool(8); % If your computer's memory is less than 8G, do not use more than 4 workers.
%    end
    for m = 1:length(methodname)

        method = methodname{m};
        [~, imgname] = fileparts(fn);
        disp(['perform ' method ' in pos (' num2str([m k]) ')' ]);  
        savepath = fullfile(savedir, imgname, [method, '.mat']);
        if exist(savepath, 'file')
            disp(['skip ' method]); 
            continue
        end
        [~, ~, bands] = size(hsi_noise);
        R_hsi = zeros(size(hsi_noise));
        cnt = zeros(size(hsi_noise));
        time = 0;
        win = bands;
        for b = 1:win:bands-win+1
            [R_hsi_curband, time_curband] = demo_fun(hsi_noise(:,:,b:b+win-1), sigma_ratio(b:b+win-1), method);
            R_hsi(:,:,b:b+win-1) = R_hsi(:,:,b:b+win-1) + R_hsi_curband;
            cnt(:,:,b:b+win-1) = cnt(:,:,b:b+win-1) + 1;
            time = time + time_curband;
        end
        if mod(bands, win) ~= 0
            [R_hsi_curband, time_curband] = demo_fun(hsi_noise(:,:,bands-win+1:bands), sigma_ratio(bands-win+1:bands), method);
            R_hsi(:,:,bands-win+1:bands) = R_hsi(:,:,bands-win+1:bands) + R_hsi_curband;
            cnt(:,:,bands-win+1:bands) = cnt(:,:,bands-win+1:bands) + 1;
            time = time + time_curband;
        end
        R_hsi = R_hsi ./ cnt;
%        R_hsi = demo_fun(hsi_noise, sigma_ratio, method);
%         [psnr, ssim, fsim, ergas, sam] = MSIQA(hsi*255, R_hsi*255);
%         fprintf('psnr: %.3f\n', psnr);
%         fprintf('ssim: %.3f\n', ssim);        
        save(savepath, 'R_hsi');
        
    end
end
