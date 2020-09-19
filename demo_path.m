% This is the testing demo for video background subtraction with OMoGMF on your video path
clear all
currentFolder = pwd;
addpath(genpath(currentFolder))
para.k=3;
para.r=2;
para.display=1;
para.ro=0.98;
para.N=50;
para.startindex=[200,1000];
para.startnumber=30;
para.iter=3;
video_path='G:\BS Videos\Li\Ariport\';%add your video image path 
run_video(video_path,para)