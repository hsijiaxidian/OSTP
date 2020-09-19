% This is the testing demo for video background subtraction with OMoGMF
clear all
currentFolder = pwd;
addpath(genpath(currentFolder))
%% read data:
% X :data matrix, each coloum vector is one frame data
% imgsize: size of each frame image
dataset = {'airport','campus','curtain','escalator','fountain','watersurface'};
num = 6;
data_name = dataset{num};
dataFolder = ['test_data\Li_dataset\' data_name '.mat'];
resFolder = ['results\' data_name '_result_OSTP'];
figpath = ['results\recorded_figure\' data_name];
recorded_index = [1,205,1196,3584];
load(dataFolder)
imgsize=[size(X,1),size(X,2)];
X=im2double(reshape(X,[size(X,1)*size(X,2),size(X,3)]));
% X = X(:,500:1500);
%% warmstart
r=2;
% ind = randperm(size(X,2));
ind=randperm(fix(size(X,2)/4))+50;
X_start=X(:,ind(1:30));
[model]  =warmstart(X_start,r,imgsize);
%% running OMoGMF
model.alpha=0.02;model.beta=0.01;model.gamma=0.01; model.p = 2/3;
model.tv.mod=0;model.imgsize=imgsize;model.tv.lamda=1;
tic;
[L,E,S,model]= OSTP(model,X,inf);
toc
save([resFolder '.mat'],'S','L');
%show result
for i=1 :size(X,2)   
I=[reshape(X(:,i),imgsize),reshape(L(:,i),imgsize),2*reshape(abs(S(:,i)),imgsize)];
 imshow(I) ;pause(0.01)
 if (find(recorded_index==i))
     imwrite(I,[figpath '_', num2str(i),'.png']);
 end
end 
