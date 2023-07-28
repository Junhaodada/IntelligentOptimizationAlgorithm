%%%%%%f(x，y)=(cos(x^2+y^2)-0.1)/(1+0.3*(x^2+y^2)^2)+3%%%%%%
clear all;              %清除所有变量
close all;              %清图
clc;                    %清屏
x=-5:0.01:5;
y=-5:0.01:5;
N=size(x,2);
for i=1:N
    for j=1:N
        z(i,j)=(cos(x(i)^2+y(j)^2)-0.1)/(1+0.3*(x(i)^2+y(j)^2)^2)+3;
    end
end
mesh(x,y,z)
xlabel('x')
ylabel('y')