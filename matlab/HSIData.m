clear;clc;close all
%% generate dataset
rng(0)
addpath(genpath('lib'));


% for iid gaussian
 basedir = 'Data';
 sz = 512;
 datadir = '../data/Testing';
 g1 = load(fullfile(basedir, '_meta_gauss.mat')); % load fns
 g2 = load(fullfile(basedir, '_meta_gauss_2.mat'));
 fns = [g1.fns;g2.fns];
 preprocess = @(x)(center_crop(rot90(x), sz, sz));
 for sigma = [30,50,70]
     newdir = fullfile(basedir, ['icvl_', num2str(sz), '_', num2str(sigma)]);
     generate_dataset(datadir, fns, newdir, sigma, 'rad', preprocess);
 end

 newdir = fullfile(basedir, ['icvl_', num2str(sz), '_', 'blind']);
 generate_dataset_blind(datadir, fns, newdir, 'rad', preprocess);


% for non-iid gaussian
 g1 = load(fullfile(basedir, '_meta_complex.mat')); % load fns
 g2 = load(fullfile(basedir, '_meta_complex_2.mat'));
 fns = [g1.fns;g2.fns];
 % fns = fns(11:end);
 datadir = '../data/Testing';
 sigmas = [10 30 50 70];
 newdir = fullfile(basedir, ['icvl_', num2str(sz), '_', 'noniid']);
 generate_dataset_noniid(datadir, fns, newdir, sigmas, 'rad', preprocess);
 %%% for non-iid gaussian + stripe
 newdir = fullfile(basedir, ['icvl_', num2str(sz), '_', 'stripe']);
 generate_dataset_stripe(datadir, fns, newdir, sigmas, 'rad', preprocess);
 %%% for non-iid gaussian + deadline
 newdir = fullfile(basedir, ['icvl_', num2str(sz), '_', 'deadline']);
 generate_dataset_deadline(datadir, fns, newdir, sigmas, 'rad', preprocess);
 %%% for non-iid gaussian + impluse
 newdir = fullfile(basedir, ['icvl_', num2str(sz), '_', 'impulse']);
 generate_dataset_impulse(datadir, fns, newdir, sigmas, 'rad', preprocess);
 %%% for mixture noise
 newdir = fullfile(basedir, ['icvl_', num2str(sz), '_','mixture']);
 generate_dataset_mixture(datadir, fns, newdir, sigmas, 'rad', preprocess);



%% for PaviaCentre
% datadir = '../data/dataset/PaviaCentre';
% fns = {'Pavia.mat'};
% sigmas = [10 30 50 70];
% sz = 256;
% preprocess = @(x)(center_crop(x(:,:,1:31), sz, sz));
% newdir = fullfile(basedir, ['pc_', num2str(sz), '_', 'noniid']);
% generate_dataset_noniid(datadir, fns, newdir, sigmas, 'pavia', preprocess);
% %%% for non-iid gaussian + stripe
% newdir = fullfile(basedir, ['pc_', num2str(sz), '_', 'stripe']);
% generate_dataset_stripe(datadir, fns, newdir, sigmas, 'pavia', preprocess);
% %%% for non-iid gaussian + deadline
% newdir = fullfile(basedir, ['pc_', num2str(sz), '_', 'deadline']);
% generate_dataset_deadline(datadir, fns, newdir, sigmas, 'pavia', preprocess);
% %%% for non-iid gaussian + impluse
% newdir = fullfile(basedir, ['pc_', num2str(sz), '_', 'impulse']);
% generate_dataset_impulse(datadir, fns, newdir, sigmas, 'pavia', preprocess);
% %%% for mixture noise
% newdir = fullfile(basedir, ['pc_', num2str(sz), '_','mixture']);
% generate_dataset_mixture(datadir, fns, newdir, sigmas, 'pavia', preprocess);

