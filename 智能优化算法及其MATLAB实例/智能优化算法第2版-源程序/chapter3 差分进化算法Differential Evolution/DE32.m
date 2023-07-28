%%%%%%%%%%%%%%%%%差分进化算法求函数极值%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%初始化%%%%%%%%%%%%%%%%%%%%%%%%
clear all;                            %清除所有变量
close all;                            %清图
clc;                                  %清屏
NP=20;                                %个体数目
D=2;                                  %变量的维数
G=100;                                %最大进化代数
F=0.5;                                %变异算子
CR=0.1;                               %交叉算子
Xs=4;                                 %上限
Xx=-4;                                %下限
%%%%%%%%%%%%%%%%%%%%%%%%%赋初值%%%%%%%%%%%%%%%%%%%%%%%%
x=zeros(D,NP);                        %初始种群
v=zeros(D,NP);                        %变异种群
u=zeros(D,NP);                        %选择种群
x=rand(D,NP)*(Xs-Xx)+Xx;              %赋初值
%%%%%%%%%%%%%%%%%%%%计算目标函数%%%%%%%%%%%%%%%%%%%%%%%
for m=1:NP
    Ob(m)=func2(x(:,m));
end
trace(1)=min(Ob);
%%%%%%%%%%%%%%%%%%%%%%%差分进化循环%%%%%%%%%%%%%%%%%%%%%
for gen=1:G
    %%%%%%%%%%%%%%%%%%%%%%变异操作%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%r1,r2,r3和m互不相同%%%%%%%%%%%%%%%
    for m=1:NP
        r1=randint(1,1,[1,NP]);
        while (r1==m)
            r1=randint(1,1,[1,NP]);
        end
        r2=randint(1,1,[1,NP]);
        while (r2==m)|(r2==r1)
            r2=randint(1,1,[1,NP]);
        end
        r3=randint(1,1,[1,NP]);
        while (r3==m)|(r3==r1)|(r3==r2)
            r3=randint(1,1,[1,NP]);
        end
        v(:,m)=x(:,r1)+F*(x(:,r2)-x(:,r3));
    end
    %%%%%%%%%%%%%%%%%%%%%%交叉操作%%%%%%%%%%%%%%%%%%%%%%%
    r=randint(1,1,[1,D]);
    for n=1:D
        cr=rand(1);
        if (cr<=CR)|(n==r)
            u(n,:)=v(n,:);
        else
            u(n,:)=x(n,:);
        end
    end
    %%%%%%%%%%%%%%%%%%%边界条件的处理%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%边界吸收%%%%%%%%%%%%%%%%%%%%%%%%%
    for n=1:D
        for m=1:NP
            if u(n,m)<Xx
                u(n,m)=Xx;
            end
            if u(n,m)>Xs
                u(n,m)=Xs;
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%选择操作%%%%%%%%%%%%%%%%%%%%%%%
    for m=1:NP
        Ob1(m)=func2(u(:,m));
    end
    for m=1:NP
        if Ob1(m)<Ob(m)
            x(:,m)=u(:,m);
        end
    end
    for m=1:NP
        Ob(m)=func2(x(:,m));
    end
    trace(gen+1)=min(Ob);
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
title('DE目标函数曲线')