function [ L ] = subspaceupdate( L,A,B,lambda1,p )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
[junk,ncol] = size(L);
for j = 1:ncol
    bj = B(:,j);
    lj = L(:,j);
    aj = A(:,j);
    temp = (bj-L*aj)/A(j,j) + lj;
    temp = str_lp(temp,lambda1/A(j,j),p);
    L(:,j) = temp;
end

end

