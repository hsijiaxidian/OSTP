function [model] = warmstart(X,r,imgsize)
% Use reweighted L2 matrix factorization to calculate U
% Use mog to calculatethe model
 disp('Warm-start...');
 disp('initializing U...');
%% PCA and L1MF for warmstart
[U,V,E]=initi_OSTP(X,r);V = V';
%% Calculating the model
disp('initializing OSTP...');
%% Calculating A and B
m=size(X,1);
A=zeros(r,r);B=zeros(m,r);
A = A + V*V';
B = B + (X-E)*V';
disp('Warm start is over. ');
%% output
model.A=A;
model.B=B;
model.U=U;
L = U*V; F = X-L;
% for i=1 :size(X,2)   
% I=[reshape(X(:,i),imgsize),reshape(L(:,i),imgsize),reshape((F(:,i)+0.5),imgsize)];
%  imshow(I) ;pause(0.1)
% end 
end