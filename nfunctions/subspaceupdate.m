function [ L ] = subspaceupdate( L,A,B,lambda1,p )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

