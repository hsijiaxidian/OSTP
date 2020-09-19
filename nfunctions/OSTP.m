function[L,E,F,model]= OSTP(model,X,iter)
%%online mog matrix factorization for video background subtraction
%input: X the data matrix;
%       model all variables and parameters for OMoGMF model 
%       model.mu the MoG pameters mu
%       model.Sigma the MoG pameters sigma^2
%       model.weight the MoG pameters pi
%       model.N controls the speed of updating MoG parameters
%       model.ro controls the speed of updating U
%       model.A and model.B auxiliary variable of subspace U
%       model.U  subspace
%       model.imgsize the frame size of video
%       model.tv.mod  switch of TV threshold: if tv.mod==1 using TV threshold
%       model.tv.lamda  parameters of TV threshold
%       iter the number of iterations
%       w_X  indicator matrix of data, if W_X_{ij}=1, X_{ij} is observed
%output:L background matrix 
%       E  residual matrix 
%       F  foreground matrix  by tv threshold
%       label data label of Gaussians 
%       model all variables and parameters for OMoGMF model 
%Written by Hongwei Yong(cshyong@comp.polyu.edu.hk or yonghw@stu.xjtu.edu.cn).
if (~isfield(model,'tv'))
       model.tv.mod=0;
       model.tv.lamda=1;
end
if (~isfield(model.tv,'lamda'))
  model.tv.lamda=1;
end
if nargin<3
  iter=inf;
end
imgsize=model.imgsize;
% lamda=tv.lamda;
[m,n]=size(X);
E=zeros(m,n);F=zeros(m,n);
V = zeros(size(model.U,2),n);
L = zeros(size(X));
tic
%% main outerloop
 for i=1:size(X,2)   
   if mod(i,500)==0||i==1
      disp(['Calculating the model of the ',num2str(i),'th frame']);
   end
[model,v,e] =onlineSTP(model,X(:,i),iter);% main function
 E(:,i)=e;
 V(:,i) = v;
 L(:,i) = model.U*v;
 %% TV threshood
 if model.tv.mod==1
     FF=reshape(E(:,i),imgsize);
     lam = model.tv.lamda*(model.Sigma(1));
     F0= TVthre(FF,lam);
 else
     FF=reshape(E(:,i),imgsize);
     F0 = FF;
 end
 %%
F(:,i)=F0(:);
 end
 
end
 
function F0= TVthre(FF,lam)
 if size(FF,3)==1
[F0] = mtv2(FF,lam,10,50,[1e-3, 1e-3],0);
 end
if  size(FF,3)==3
   [F0(:,:,1)]=mtvp2(FF(:,:,1), lam,10,50,[1e-3, 1e-3],0); 
   [F0(:,:,2)]=mtvp2(FF(:,:,2), lam,10,50,[1e-3, 1e-3],0); 
   [F0(:,:,3)]=mtvp2(FF(:,:,3), lam,10,50,[1e-3, 1e-3],0); 
end
end
