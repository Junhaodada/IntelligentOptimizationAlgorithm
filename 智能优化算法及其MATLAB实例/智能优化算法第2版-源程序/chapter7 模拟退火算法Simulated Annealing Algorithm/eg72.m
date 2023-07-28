%%%%%%%%%f(x，y)=5*cos(x*y)+x*y+y^3%%%%%%%%%
clear all;              %清除所有变量
close all;              %清图
clc;                    %清屏
x=-5:0.02:5;
y=-5:0.02:5;
N=size(x,2);
for i=1:N
    for j=1:N
         z(i,j)=5*cos(x(i)*y(j))+x(i)*y(j)+y(j)^3;
    end
end
mesh(x,y,z)
xlabel('x')
ylabel('y')