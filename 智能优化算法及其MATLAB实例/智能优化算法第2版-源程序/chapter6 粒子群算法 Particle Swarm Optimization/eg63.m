%%%%%%%%%f(x)=x+6sin(4x)+9cos(5x)%%%%%%%%%%
clear all;              %清除所有变量
close all;              %清图
clc;                    %清屏
x=0:0.01:9;
y=x+6*sin(4*x)+9*cos(5*x);
plot(x,y)
xlabel('x')
ylabel('f(x)')
title('f(x)=x+6sin(4x)+9cos(5x)')