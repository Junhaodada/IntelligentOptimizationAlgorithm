%%%%%%%%%%%%%%%%%差分进化算法求函数极值%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%初始化%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;                            %清除所有变量
close all;                            %清图
clc;                                  %清屏
NP=50;                                %个体数目
D=10;                                 %变量的维数
G=200;                                %最大进化代数
F0=0.4;                               %初始变异算子
CR=0.1;                               %交叉算子
Xs=20;                                %上限
Xx=-20;                               %下限
yz=10^-6;                             %阈值
%%%%%%%%%%%%%%%%%%%%%%%%%赋初值%%%%%%%%%%%%%%%%%%%%%%%%
x=zeros(D,NP);                        %初始种群
v=zeros(D,NP);                        %变异种群
u=zeros(D,NP);                        %选择种群
x=rand(D,NP)*(Xs-Xx)+Xx;              %赋初值
   %%%%%%%%%%%%%%%%%%%%计算目标函数%%%%%%%%%%%%%%%%%%%%
for m=1:NP
    Ob(m)=func1(x(:,m));
end
trace(1)=min(Ob);
%%%%%%%%%%%%%%%%%%%%%%%差分进化循环%%%%%%%%%%%%%%%%%%%%%
for gen=1:G
    %%%%%%%%%%%%%%%%%%%%%%变异操作%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%自适应变异算子%%%%%%%%%%%%%%%%%%%
    lamda=exp(1-G/(G+1-gen));
    F=F0*2^(lamda);
    %%%%%%%%%%%%%%%%%r1,r2,r3和m互不相同%%%%%%%%%%%%%%%%
    for m=1:NP
        r1=randi([1,NP],1,1);
        while (r1==m)
            r1=randi([1,NP],1,1);
        end
        r2=randi([1,NP],1,1);
        while (r2==m)|(r2==r1)
            r2=randi([1,NP],1,1);
        end
        r3=randi([1,NP],1,1);
        while (r3==m)|(r3==r1)|(r3==r2)
            r3=randi([1,NP],1,1);
        end
        v(:,m)=x(:,r1)+F*(x(:,r2)-x(:,r3));
    end
    %%%%%%%%%%%%%%%%%%%%%%交叉操作%%%%%%%%%%%%%%%%%%%%%%%
    r=randi([1,D],1,1);
    for n=1:D
        cr=rand(1);
        if (cr<=CR)|(n==r)
            u(n,:)=v(n,:);
        else
            u(n,:)=x(n,:);
        end
    end
    %%%%%%%%%%%%%%%%%%%边界条件的处理%%%%%%%%%%%%%%%%%%%%%
    for n=1:D
        for m=1:NP
            if (u(n,m)<Xx)|(u(n,m)>Xs)
                u(n,m)=rand*(Xs-Xx)+Xx;
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%选择操作%%%%%%%%%%%%%%%%%%%%%%%
    for m=1:NP
        Ob1(m)=func1(u(:,m));
    end
    for m=1:NP
        if Ob1(m)<Ob(m)
            x(:,m)=u(:,m);
        end
    end  
    for m=1:NP
        Ob(m)=func1(x(:,m));
    end
    trace(gen+1)=min(Ob);
    if min(Ob(m))<yz
        break
    end
end
[SortOb,Index]=sort(Ob);
x=x(:,Index);
X=x(:,1);                              %最优变量              
Y=min(Ob);                             %最优值  
%%%%%%%%%%%%%%%%%%%%%%%%%画图%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
plot(trace);
xlabel('迭代次数')
ylabel('目标函数值')
title('适应度进化曲线')