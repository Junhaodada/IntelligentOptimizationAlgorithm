%%%%%%%%%%%%%%%遗传算法解决0-1背包问题%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%初始化参数%%%%%%%%%%%%%%%%%%%%%%
clear all;                       %清变量
close all;                       %清图
clc;                             %清屏
NP = 50;                         %种群规模
L = 10;                          %物品件数
Pc = 0.8;                        %交叉率
Pm = 0.05;                       %变异率
G = 100;                         %最大遗传代数
V = 300;                             %背包容量
C = [95,75,23,73,50,22,6,57,89,98];  %物品体积
W = [89,59,19,43,100,72,44,16,7,64]; %物品价值
afa = 2;                             %惩罚函数系数
f = randint(NP,L);                   %随机获得初始种群
%%%%%%%%%%%%%%%%%%%%%遗传算法循环%%%%%%%%%%%%%%%%%%%%%
for k = 1:G
    %%%%%%%%%%%%%%%%%%适应度计算%%%%%%%%%%%%%%%%%
    for i = 1:NP
         Fit(i) = func4(f(i,:),C,W,V,afa);
    end
    maxFit = max(Fit);                          %最大值
    minFit = min(Fit);                          %最小值
    rr = find(Fit==maxFit);
    fBest = f(rr(1,1),:);                       %历代最优个体
    Fit = (Fit - minFit)/(maxFit - minFit);     %归一化适应度值
    %%%%%%%%%%%%%%基于轮盘赌的复制操作%%%%%%%%%%%%%
    sum_Fit = sum(Fit);
    fitvalue = Fit./sum_Fit;
    fitvalue = cumsum(fitvalue);
    ms = sort(rand(NP,1));
    fiti = 1;
    newi = 1;
    while newi <= NP
        if (ms(newi)) < fitvalue(fiti)
            nf(newi,:) = f(fiti,:);
            newi = newi + 1;
        else
            fiti = fiti + 1;
        end
    end
    %%%%%%%%%%%%%%%基于概率的交叉操作%%%%%%%%%%%%%
    for i = 1:2:NP
        p = rand;
        if p < Pc
            q = randint(1,L);
            for j = 1:L
                if q(j)==1;
                    temp = nf(i + 1,j);
                    nf(i + 1,j) = nf(i,j);
                    nf(i,j) = temp;
                end
            end
        end
    end
    %%%%%%%%%%%%%基于概率的变异操作%%%%%%%%%%%%%%
    for m = 1:NP
        for n = 1:L
            r = rand(1,1);
            if r < Pm
                nf(m,n) = ~nf(m,n);
            end
        end
    end
    f = nf;
    f(1,:) = fBest;                     %保留最优个体在新种群中
    trace(k) = maxFit;                  %历代最优适应度
end
fBest;                                  %最优个体
figure
plot(trace)
xlabel('迭代次数')
ylabel('目标函数值')
title('适应度进化曲线')
