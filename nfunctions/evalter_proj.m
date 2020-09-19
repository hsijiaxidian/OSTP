function [model] = evalter_proj(model,z,maxIter)
% solve the problem: 
%   min_{x,e} 0.5*|z-Dx-e|_2^2 + 0.5*lambda1*|x|_2^2 + lambda2*|e|_1
lambda1 = model.beta; lambda2 = model.gamma;
D = model.U;
% initialization
[ndim,ncol] = size(D);
if (~isfield(model,'v'))
x=zeros(ncol,1);
else
x=model.v;% 把系数初始化为前一帧的系数。
end
e = zeros(ndim,1);
I = eye(ncol);
converged = false;
iter = 0;
% alternatively update
DDt = (D'*D+lambda1*I)\D';
while ~converged
    iter = iter + 1;
    etemp = e;
    e = thres(z-D*x,lambda2);
    xtemp = x;
    x = DDt*(z-e);
%     x = (D'*D + lambda1*I)\(D'*(z-e));   
    stopc = max(norm(e-etemp), norm(x-xtemp))/ndim;
    if stopc < 1e-6 || iter > maxIter
        converged = true;
    end
%     fval = func_proj(z,D,lambda1,lambda2,x,e);
%     fprintf('fval = %f\n', fval);
end
model.v = x;
model.e = e;

end

function x = thres(y,mu)
    x = max(y-mu, 0);
    x = x + min(y + mu, 0);
end

function fval = func_proj(z,D,lambda1,lambda2,x,e)
fval = 0;
fval = fval + 0.5*norm(z-D*x-e)^2;
fval = fval + 0.5*lambda1*norm(x)^2;
fval = fval + lambda2*sum(abs(e));
end


