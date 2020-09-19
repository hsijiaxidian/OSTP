function [model,label,L,E,TX,Tau]=it_OMoGMF(X,model,iter)
E=zeros(size(X));L=zeros(size(X));label=zeros(size(X));TX=zeros(size(X));
Tau=zeros(6,size(X,2));
for it=1:iter 
disp(['the ',num2str(it),'th  iteration']);
[L,TX,E,label,model,Tau]= t_OMoGMF(model,X,5,Tau);
end