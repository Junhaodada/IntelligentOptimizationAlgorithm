%%%%%%%f(x，y)=20*(x^2-y^2)^2-(1-y)^2-3*(1+y)^2+0.3%%%%%%%
clear all;              %清除所有变量
close all;              %清图
clc;                    %清屏
x=-5:0.01:5;
y=-5:0.01:5;
N=size(x,2);
for i=1:N
    for j=1:N
        z(i,j)=20*(x(i)^2-y(j)^2)^2-(1-y(j))^2-3*(1+y(j))^2+0.3;
    end
end
mesh(x,y,z)
xlabel('x')
ylabel('y')