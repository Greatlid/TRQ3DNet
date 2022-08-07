addpath(genpath('lib'));
% datadir = fullfile('Data','Indian');
datadir = fullfile('../data/dataset','Urban');
% datadir = fullfile('Data','Harvard');

% resdir = fullfile('Result', 'Indian');
resdir = fullfile('Result', 'Urban');
% resdir = fullfile('Result', 'Harvard');

% fns = {'Indian_pines.mat'};
fns = {'Urban.mat'};
% fns = {'img1.mat'};
methodname = {'None', 'BM4D','TDL', 'ITSReg', 'LLRT','LRMR','LRTV','NMoG','LRTDTV'};

for m = 1:length(methodname)
    method = methodname{m};
    for k = 1:length(fns)
        fn = fns{k};
        [~, imgname] = fileparts(fn);
        imgdir = fullfile(resdir, imgname);
        savepath = fullfile(imgdir, [methodname{m}, '.mat']);
        if ~exist(imgdir, 'dir')
            mkdir(imgdir);
        end
        if exist(savepath, 'file')
            disp(['reuse precomputed result in pos (' num2str([m k]) ')']);
            break
        end
        load(fullfile(datadir, fn))
        sigma_ratio = double(real(NoiseLevel(hsi))); 
        disp(['perform ' method ' in pos (' num2str([m k]) ')' ]);
        R_hsi = zeros(size(noisy_hsi));
        cnt = zeros(size(noisy_hsi));
        time = 0;
        win = 31;
        for b = 1:bands-win+1
            [R_hsi_curband, time_curband] = demo_fun(noisy_hsi(:,:,b:b+win-1), sigma_ratio(b:b+win-1), methodname{m});
            R_hsi(:,:,b:b+win-1) = R_hsi(:,:,b:b+win-1) + R_hsi_curband;
            cnt(:,:,b:b+win-1) = cnt(:,:,b:b+win-1) + 1;
            time = time + time_curband;
        end
        R_hsi = R_hsi ./ cnt;

%        R_hsi = demo_fun(hsi, sigma_ratio, methodname{m});
        save(savepath, 'R_hsi');
    end
end



