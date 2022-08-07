clear;close all;clc;
addpath(genpath('lib'));
 method = {'None', 'BM4D', 'TDL', 'ITSReg', 'LLRT','LRMR','LRTV','NMoG','LRTDTV', 'hsidcnnnet', 'swinir', 'qrnn3d', 'stq3d_cfmscn'};
result = [];
allscore = [];
for i = 1:length(method)
%     img = load(['../images/indian_pines/', method{i}, '.mat']);
    img = load(['../images/Urban/', method{i}, '.mat']);
    img = img.R_hsi;
    [~, ~, c] = size(img);
    score = double(real(NoiseLevel(img)))* 255;
    result = [result mean(score)];
    allscore = [allscore;score];
    disp([method{i}, ':', num2str(mean(score))])
end

