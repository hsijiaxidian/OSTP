function[L,TX,E,label,model,Tau]= t_OMoGMF(model,X,iter,Tau)
%%transformed online mog matrix factorization for video background subtraction
%input: X the data matrix;
%       model  all variables and parameters for t-OMoGMF model 
%       model.mu the MoG pameters mu
%       model.Sigma the MoG pameters sigma^2
%       model.weight the MoG pameters pi
%       model.N controls the speed of updating MoG parameters
%       model.ro controls the speed of updating U
%       model.A and model.B auxiliary variable of subspace U
%       model.U  subspace
%       model.imgsize the frame size of video
%       iter the number of iterations
%       Tau transformation parameters
%output:L background matrix 
%       TX transformed data matrix
%       E  residual matrix 
%       label data label of Gaussians 
%       model all variables and parameters for t-OMoGMF model 
%       Tau transformation parameters
%Written by Hongwei Yong(cshyong@comp.polyu.edu.hk or yonghw@stu.xjtu.edu.cn).
if nargin<3
    iter=20;
end
if nargin<4
Tau=zeros(6,size(X,2));
end
U=model.U;
E=zeros(size(X));L=zeros(size(X));label=zeros(size(X));TX=zeros(size(X));
tic
 for i=1:size(X,2)    
     if mod(i,50)==0
       disp(['Calculating the model of the ',num2str(i),'th frame']);
     end
[model,v,label0,~,B,Tau(:,i)] =t_onlinemogmf(model,X(:,i),Tau(:,i),iter);
U=model.U;
L(:,i)=U*v;
E(:,i)=B(:)-L(:,i);
label(:,i)=label0;
TX(:,i)=B(:);
 end

