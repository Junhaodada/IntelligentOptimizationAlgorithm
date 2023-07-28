%%%%%%%%%f(x,y)=5*sin(x*y)+x*x+y*y%%%%%%%%%%
clear all;              %清除所有变量
close all;              %清图
clc;                    %清屏
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