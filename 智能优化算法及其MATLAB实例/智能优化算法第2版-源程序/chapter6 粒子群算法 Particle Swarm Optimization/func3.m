%%%%%%%%%%%%%%%%%%%%%%%%%��Ӧ�Ⱥ���%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result=func3(x,Xs,Xx)
m=0;
D=length(x);
for j=1:D
    m=x(j)*2^(j-1)+m;
end
f=Xx+m*(Xs-Xx)/(2^D-1);            %�����ʮ������
fit= f+6*sin(4*f)+9*cos(5*f);
result=fit;
