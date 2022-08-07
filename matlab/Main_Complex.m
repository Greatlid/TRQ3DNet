%==========================================================================
% clc;
clear;
close all;
addpath(genpath('lib'));

%% Data init
basedir = 'Data';
datadir = '../data';
fns = load(fullfile(basedir, '_meta_complex_test.mat')); % load fns
fns = fns.fns;
methodname = {'None','LRMR','LRTV','NMoG','LRTDTV'};
ds_names = {'icvl_512_noniid', 'icvl_512_stripe', 'icvl_512_deadline', 'icvl_512_impulse', 'icvl_512_mixture'};
for i = 1:length(ds_names)
    dataset_name = ds_names{i};
    datadir = fullfile(datadir, dataset_name);
    resdir = fullfile('Result', dataset_name);
    HSI_test(datadir, resdir, fns, methodname);
end

