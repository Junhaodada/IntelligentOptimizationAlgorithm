%%%%%%%%%f(x)=x+6sin(4x)+9cos(5x)%%%%%%%%%%
clear all;              %������б���
close all;              %��ͼ
clc;                    %����
x=0:0.01:9;
y=x+6*sin(4*x)+9*cos(5*x);
plot(x,y)
xlabel('x')
ylabel('f(x)')
title('f(x)=x+6sin(4x)+9cos(5x)')