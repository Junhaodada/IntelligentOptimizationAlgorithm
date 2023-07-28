%%%%%%%%f(x,y)=-((x^2+y-1).^2+(x+y^2-7)^2)/200+10%%%%%%%%
clear all;              %清除所有变量
close all;              %清图
clc;                    %清屏
x=-100:1:100;
y=-100:1:100;
N=size(x,2);
for i=1:N
    for j=1:N
        z(i,j)=-((x(i)^2+y(j)-1).^2+(x(i)+y(j)^2-7)^2)/200+10;
    end
end
mesh(x,y,z)
xlabel('x')
ylabel('y')