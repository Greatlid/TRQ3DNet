clear
clc
close all
base_folder = '../images';

files = dir(fullfile(base_folder));
folder_nums = size(files, 1);

folder_names = { };
% �ļ������ļ��е������Ǵӵ�3λ��ʼ�ģ�������Ҫע��
for i = 3:folder_nums
    folder_names{i-2} = files(i,1).name;
end
folder_names(2) = [];
folder_names(4) = [];
folder_names(4) = [];
for i = 1:length(folder_names)
    folder_name = folder_names{i};
    test{i} = fullfile(base_folder,folder_name);
end

num=1;
X=140;Y=380;small_size=50;scale=4.5;
% path = fullfile(test{6},'NMoG.mat');
path = 'E:\PL\ѧϰ����\ͼ��ȥ��\code\Project\STQ3D\images\Lehavim_0910-1627\qrnn3d.mat';
frm = draw_after(path,X,Y,small_size,scale);
print('SameAxisLimits','-dpng','-r600')
frm = draw_after(fullfile(test{num},'memnet.mat'),X,Y,small_size,scale);
frm = draw_after(fullfile(test{num},'LRTV.mat'),X,Y,small_size,scale);
frm = draw_after(fullfile(test{num},'LRTDTV.mat'),X,Y,small_size,scale);
frm = draw_after(fullfile(test{num},'LRMR.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'stq3d_cfmscn.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'qrnn3d.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'None.mat'),X,Y,small_size,scale);


% num=2;
% X=227;Y=115;small_size=50;scale=4.5;
% % frm = draw_after(fullfile(test{num},'NMoG.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'memnet.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'LRTV.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'LRTDTV.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'LRMR.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'stq3d_cfmscn.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'qrnn3d.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'None.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'BM4D.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'ITSReg.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LLRT.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'TDL.mat'),X,Y,small_size,scale);
% 
% 
% num=3;
% X=360;Y=60;small_size=50;scale=4.5;
% frm = draw_after(fullfile(test{num},'NMoG.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'memnet.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRTV.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRTDTV.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRMR.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'stq3d_cfmscn.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'qrnn3d.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'None.mat'),X,Y,small_size,scale);
% 
% 
% 
% num=4;
% X=65;Y=2;small_size=50;scale=4.5;
% frm = draw_after(fullfile(test{num},'NMoG.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'memnet.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRTV.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRTDTV.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRMR.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'stq3d_cfmscn.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'qrnn3d.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'None.mat'),X,Y,small_size,scale);
% 
% 
% 
% 
% num=5;
% X=190;Y=80;small_size=50;scale=4.5;
% frm = draw_after(fullfile(test{num},'NMoG.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'memnet.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRTV.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRTDTV.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRMR.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'stq3d_cfmscn.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'qrnn3d.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'None.mat'),X,Y,small_size,scale);
% 
% 
% 
% num=6;
% X=230;Y=140;small_size=50;scale=4.5;
% frm = draw_after(fullfile(test{num},'NMoG.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'memnet.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRTV.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRTDTV.mat'),X,Y,small_size,scale);
% frm = draw_after(fullfile(test{num},'LRMR.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'stq3d_cfmscn.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'qrnn3d.mat'),X,Y,small_size,scale);
% % frm = draw_after(fullfile(test{num},'None.mat'),X,Y,small_size,scale);
% 




function [frm] = draw_after(file_name,X,Y,small_size,scale)
%DRAW �˴���ʾ�йش˺�����ժҪ
% file_name:  xxx.mat
% X,Y:  С�������Ͻǵ�λ��
% small_size: С���γߴ磨�߳���
% scale:�������С���εļ���
%   �˴���ʾ��ϸ˵��
data = cell2mat(struct2cell(load(file_name)));

img = data(:,:,20);

[heigh, width] = size(img);

img = (img-min(min(img)))/(max(max(img))-min(min(img)));  % ��һ��

%%%%%С���ο�ĳߴ�
X1 = X;
Y1 = Y;
width_small = small_size;
heigh_small = small_size;


%ZoomIn����
subgraph = img(Y1:Y1+width_small, X1:X1+heigh_small);
subgraph = imresize(subgraph, scale);  % �Ŵ�5��

%%%%%����ο�ĳߴ�
width_zoom = size(subgraph, 2);
heigh_zoom = size(subgraph, 1);
X2 = size(img, 2) - width_zoom;
Y2 = size(img, 1) - heigh_zoom;


%%%%��ͼ
fh = figure;
% imshow(img); % show your image
imshow(img,'border','tight','initialmagnification','fit');
set (gcf,'Position',[0,0,heigh, width]);
hold on;
img(heigh-heigh_zoom+1:heigh, width-width_zoom+1:width) = subgraph;  %���½���ʾ�Ŵ��ͼ
imshow(img)
hold on;

% imshow(img,'border','tight','initialmagnification','fit');
% img = imresize(img, [512, 512]);
% set (gcf,'Position',[0,0,512,512]);  % ǰ�������崰������Ļ��λ�ã����������ڴ�С
% imshow(img,'border','tight','initialmagnification','fit');


% [pathstr, name, ext]=fileparts(file_name);
% title(file_name);

% draw rectangle on image
rectangle('Position', [X1 Y1 width_small heigh_small] ,'LineWidth',1,'EdgeColor','r');
rectangle('Position', [X2 Y2 width_zoom   heigh_zoom] ,'LineWidth',1,'EdgeColor','r'); 

frm = getframe(fh); % get the image + rectangle
end


