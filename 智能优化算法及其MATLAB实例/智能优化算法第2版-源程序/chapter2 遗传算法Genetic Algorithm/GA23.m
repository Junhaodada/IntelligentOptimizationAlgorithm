%%%%%%%%%%%%%%%%%%%%%%%%%遗传算法解决TSP问题%%%%%%%%%%%%%%%%%%%%%%%
clear all;                      %清除所有变量
close all;                      %清图
clc;                            %清屏
C=[1304 2312;3639 1315;4177 2244;3712 1399;3488 1535;3326 1556;...
    3238 1229;4196 1044;4312  790;4386  570;3007 1970;2562 1756;...
    2788 1491;2381 1676;1332  695;3715 1678;3918 2179;4061 2370;...
    3780 2212;3676 2578;4029 2838;4263 2931;3429 1908;3507 2376;...
    3394 2643;3439 3201;2935 3240;3140 3550;2545 2357;2778 2826;...
    2370 2975];                 %31个省会城市坐标
N=size(C,1);                    %TSP问题的规模,即城市数目
D=zeros(N);                     %任意两个城市距离间隔矩阵
%%%%%%%%%%%%%%%%%%%%%求任意两个城市距离间隔矩阵%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    for j=1:N
        D(i,j)=((C(i,1)-C(j,1))^2+(C(i,2)-C(j,2))^2)^0.5;
    end
end
NP=200;                          %种群规模
G=1000;                          %最大遗传代数
f=zeros(NP,N);                   %用于存储种群
F=[];                            %种群更新中间存储
for i=1:NP
    f(i,:)=randperm(N);          %随机生成初始种群
end
R=f(1,:);                        %存储最优种群
len=zeros(NP,1);                 %存储路径长度
fitness=zeros(NP,1);             %存储归一化适应值
gen=0;
%%%%%%%%%%%%%%%%%%%%%%%%%遗传算法循环%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while gen<G
    %%%%%%%%%%%%%%%%%%%%%计算路径长度%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:NP
        len(i,1)=D(f(i,N),f(i,1));
        for j=1:(N-1)
            len(i,1)=len(i,1)+D(f(i,j),f(i,j+1));
        end
    end
    maxlen=max(len);              %最长路径
    minlen=min(len);              %最短路径
    %%%%%%%%%%%%%%%%%%%%%%%%%更新最短路径%%%%%%%%%%%%%%%%%%%%%%%%%%
    rr=find(len==minlen);
    R=f(rr(1,1),:);
    %%%%%%%%%%%%%%%%%%%%%计算归一化适应值%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:length(len)
        fitness(i,1)=(1-((len(i,1)-minlen)/(maxlen-minlen+0.001)));
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%选择操作%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    nn=0;
    for i=1:NP
        if fitness(i,1)>=rand
            nn=nn+1;
            F(nn,:)=f(i,:);
        end
    end
    [aa,bb]=size(F);
    while aa<NP
        nnper=randperm(nn);
        A=F(nnper(1),:);
        B=F(nnper(2),:);
        %%%%%%%%%%%%%%%%%%%%%%%交叉操作%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        W=ceil(N/10);              %交叉点个数
        p=unidrnd(N-W+1);          %随机选择交叉范围，从p到p+W
        for i=1:W
            x=find(A==B(p+i-1));
            y=find(B==A(p+i-1));
            temp=A(p+i-1);
            A(p+i-1)=B(p+i-1); 
            B(p+i-1)=temp;
            temp=A(x); 
            A(x)=B(y); 
            B(y)=temp;
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%变异操作%%%%%%%%%%%%%%%%%%%%%%%%%
        p1=floor(1+N*rand());
        p2=floor(1+N*rand());
        while p1==p2
            p1=floor(1+N*rand());
            p2=floor(1+N*rand());
        end
        tmp=A(p1); 
        A(p1)=A(p2); 
        A(p2)=tmp;
        tmp=B(p1); 
        B(p1)=B(p2); 
        B(p2)=tmp;
        F=[F;A;B];
        [aa,bb]=size(F);
    end
    if aa>NP
        F=F(1:NP,:);             %保持种群规模为n
    end
    f=F;                         %更新种群
    f(1,:)=R;                    %保留每代最优个体
    clear F;
    gen=gen+1
    Rlength(gen)=minlen;
end
figure
for i=1:N-1
    plot([C(R(i),1),C(R(i+1),1)],[C(R(i),2),C(R(i+1),2)],'bo-');
    hold on;
end
plot([C(R(N),1),C(R(1),1)],[C(R(N),2),C(R(1),2)],'ro-');
title(['优化最短距离:',num2str(minlen)]);
figure
plot(Rlength)
xlabel('迭代次数')
ylabel('目标函数值')
title('适应度进化曲线')