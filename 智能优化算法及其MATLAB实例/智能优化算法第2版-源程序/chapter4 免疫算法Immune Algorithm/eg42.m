%%%%%%%%%f(x,y)=5*sin(x*y)+x*x+y*y%%%%%%%%%%
clear all;              %������б���
close all;              %��ͼ
clc;                    %����
x=-4:0.02:4;
y=-4:0.02:4;
N=size(x,2);
for i=1:N
    for j=1:N
        z(i,j)=5*sin(x(i)*y(j))+x(i)*x(i)+y(j)*y(j);
    end
end
mesh(x,y,z)
xlabel('x')
ylabel('y')