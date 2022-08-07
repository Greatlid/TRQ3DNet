%==========================================================================
% clc;
clear;
close all;
addpath(genpath('lib'));

%% Data init
basedir = 'Data';
datadir = '../data';
fns = load(fullfile(basedir, '_meta_gauss_test.mat')); % load fns
fns = fns.fns;

methodname = {'None','BM4D','TDL', 'ITSReg','LLRT'};

if isempty(gcp)
    parpool(4,'IdleTimeout', inf); % If your computer's memory is less than 8G, do not use more than 4 workers.
end

ds_names = {'icvl_512_30', 'icvl_512_50', 'icvl_512_70', 'icvl_512_blind'};
for i = 1:length(ds_names)
    dataset_name = ds_names{i};
    datadir = fullfile(datadir, dataset_name);
    resdir = fullfile('Result', dataset_name);
    HSI_test(datadir, resdir, fns, methodname);
end


