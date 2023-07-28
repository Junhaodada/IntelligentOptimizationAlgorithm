%%%%%%%%%%%%%%%%%%%%实值遗传算法求函数极值%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%初始化%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;                           %清除所有变量
close all;                           %清图
clc;                                 %清屏
D=10;                                %基因数目    
NP=100;                              %染色体数目
Xs=20;                               %上限          
Xx=-20;                              %下限
G=1000;                               %最大遗传代数
f=zeros(D,NP);                       %初始种群赋空间
nf=zeros(D,NP);                      %子种群赋空间
Pc=0.8;                              %交叉概率
Pm=0.1;                              %变异概率
f=rand(D,NP)*(Xs-Xx)+Xx;             %随机获得初始种群
%%%%%%%%%%%%%%%%%%%%%%按适应度升序排列%%%%%%%%%%%%%%%%%%%%%%%
for np=1:NP
    MSLL(np)=func2(f(:,np));
end
[SortMSLL,Index]=sort(MSLL);                            
Sortf=f(:,Index);
%%%%%%%%%%%%%%%%%%%%%%%遗传算法循环%%%%%%%%%%%%%%%%%%%%%%%%%%
for gen=1:G
    %%%%%%%%%%%%%%采用君主方案进行选择交叉操作%%%%%%%%%%%%%%%%
    Emper=Sortf(:,1);                      %君主染色体
    NoPoint=round(D*Pc);                   %每次交叉点的个数
    PoPoint=randint(NoPoint,NP/2,[1 D]);   %交叉基因的位置
    nf=Sortf;
    for i=1:NP/2
        nf(:,2*i-1)=Emper;
        nf(:,2*i)=Sortf(:,2*i);
        for k=1:NoPoint
            nf(PoPoint(k,i),2*i-1)=nf(PoPoint(k,i),2*i);
            nf(PoPoint(k,i),2*i)=Emper(PoPoint(k,i));
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%变异操作%%%%%%%%%%%%%%%%%%%%%%%%%
    for m=1:NP
        for n=1:D
            r=rand(1,1);
            if r<Pm
                nf(n,m)=rand(1,1)*(Xs-Xx)+Xx;
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%子种群按适应度升序排列%%%%%%%%%%%%%%%%%%
    for np=1:NP 
          NMSLL(np)=func2(nf(:,np));   
    end
    [NSortMSLL,Index]=sort(NMSLL);           
    NSortf=nf(:,Index);
    %%%%%%%%%%%%%%%%%%%%%%%%%产生新种群%%%%%%%%%%%%%%%%%%%%%%%%%%
    f1=[Sortf,NSortf];                %子代和父代合并
    MSLL1=[SortMSLL,NSortMSLL];       %子代和父代的适应度值合并
    [SortMSLL1,Index]=sort(MSLL1);    %适应度按升序排列
    Sortf1=f1(:,Index);               %按适应度排列个体
    SortMSLL=SortMSLL1(1:NP);         %取前NP个适应度值
    Sortf=Sortf1(:,1:NP);             %取前NP个个体
    trace(gen)=SortMSLL(1);           %历代最优适应度值
end
Bestf=Sortf(:,1);                     %最优个体 
trace(end)                            %最优值
figure
plot(trace)
xlabel('迭代次数')
ylabel('目标函数值')
title('适应度进化曲线')