function [model,v,e ] = onlineSTP( model,y,iter )
if nargin<3
   iter=inf;
end
alpha = model.alpha;U = model.U;
p = model.p;
%% solve for the coefficient and noise for sample y
[model] = evalter_proj(model,y,iter);
v = model.v;e = model.e;

%% update the memory variable A and B
A = model.A + v*v'; model.A = A; % A和B也同样用warmstart给出的结果进行初始化
B = model.B + (y-e)*v'; model.B = B;

%% update the subspace
q = 2*p/(2-p);
U = subspaceupdate(U,A,B,alpha,q);
model.U = U;
end

