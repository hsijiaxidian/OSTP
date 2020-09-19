function [ Y ] = str_lp( X,lambda,p )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
d = sqrt(sum(X.^2));
Normili_w = 1/(d+eps);
if p==1
    c = max(d-lambda,0);
    Y = X*Normili_w*c;
elseif p==2
    c = d/(1+2*lambda);
    Y = X*Normili_w*c;
elseif p<1
    c = solve_Lp(d,lambda,p);
    Y = X*Normili_w*c;
else
    error('The specific "p" is not supported right now :) \n')
end

end

function   x   =  solve_Lp( y, lambda, p )
   if p==1
       J =   1;
   elseif p<1;
       J =   5;
   end
    tau   =  (2*lambda.*(1-p))^(1/(2-p)) + p*lambda.*(2*(1-p)*lambda)^((p-1)/(2-p));
    x     =   zeros( size(y) );
    i0    =   find( y>tau );

    if length(i0)>=1
        % lambda  =   lambda(i0);
        y0    =   y(i0);
        t     =   y0;
        for  j  =  1 : J
            t    =  y0 - p*lambda.*(t).^(p-1);
        end
        x(i0)   =  max(t,0);
    end

    % f=@(x,y)lambda*x^p+1/2*(x-y)^2;
    % error=zeros(1,length(i0));
    % for j=1:length(i0)
    %   error(j)=f(0,y(i0(j)))-f(x(i0(j)),y(i0(j)));
    % end
    % error
end