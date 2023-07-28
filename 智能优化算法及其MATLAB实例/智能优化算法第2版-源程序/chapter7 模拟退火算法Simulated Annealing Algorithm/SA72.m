%%%%%%%%%%%%%%%%%%%%%%模拟退火算法解决函数极值%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%初始化%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;                      %清除所有变量
close all;                      %清图
clc;                            %清屏
XMAX= 5;                        %搜索变量x最大值
XMIN= -5;                       %搜索变量x最小值
YMAX= 5;                        %搜索变量y最大值
YMIN= -5;                       %搜索变量y最小值
%%%%%%%%%%%%%%%%%%%%%%%%%%%冷却表参数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = 100;                        %马可夫链长度
K = 0.99;                       %衰减参数
S = 0.02;                       %步长因子
T=100;                          %初始温度
YZ = 1e-8;                      %容差
P = 0;                          %Metropolis过程中总接受点
%%%%%%%%%%%%%%%%%%%%%%%%%%随机选点 初值设定%%%%%%%%%%%%%%%%%%%%%%%%%
PreX =  rand * (XMAX-XMIN)+XMIN;
PreY =  rand * (YMAX-YMIN)+YMIN; 
PreBestX = PreX;
PreBestY = PreY;
PreX =  rand * (XMAX-XMIN)+XMIN;
PreY =  rand * (YMAX-YMIN)+YMIN; 
BestX = PreX;
BestY = PreY;
%%%%%%%%%%%每迭代一次退火一次(降温), 直到满足迭代条件为止%%%%%%%%%%%%
deta=abs( func2( BestX,BestY)-func2 (PreBestX, PreBestY));
while (deta > YZ) && (T>0.001)
    T=K*T; 
    %%%%%%%%%%%%%%%%%%%%%在当前温度T下迭代次数%%%%%%%%%%%%%%%%%%%%%%
    for i=1:L  
        %%%%%%%%%%%%%%%%%在此点附近随机选下一点%%%%%%%%%%%%%%%%%%%%%
        p=0;
        while p==0
            NextX = PreX + S* (rand * (XMAX-XMIN)+XMIN);
            NextY = PreY + S*( rand * (YMAX-YMIN)+YMIN);
            if (NextX >= XMIN && NextX <= XMAX && NextY >=...
                    YMIN && NextY <= YMAX)
                p=1;
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%是否全局最优解%%%%%%%%%%%%%%%%%%%%%%
        if (func2(BestX,BestY) > func2(NextX,NextY))
            %%%%%%%%%%%%%%%%%%保留上一个最优解%%%%%%%%%%%%%%%%%%%%%
            PreBestX = BestX;
            PreBestY = BestY;
            %%%%%%%%%%%%%%%%%%%此为新的最优解%%%%%%%%%%%%%%%%%%%%%
            BestX=NextX;
            BestY=NextY;
        end
        %%%%%%%%%%%%%%%%%%%%%%%% Metropolis过程%%%%%%%%%%%%%%%%%%%
        if( func2(PreX,PreY) - func2(NextX,NextY) > 0 )
            %%%%%%%%%%%%%%%%%%%%%%%接受新解%%%%%%%%%%%%%%%%%%%%%%%%
            PreX=NextX;
            PreY=NextY;
            P=P+1;
        else
            changer = -1*(func2(NextX,NextY)-func2(PreX,PreY))/ T ;
            p1=exp(changer);
            %%%%%%%%%%%%%%%%%%%%%%%%接受较差的解%%%%%%%%%%%%%%%%%%%%
            if p1 > rand        
                PreX=NextX;
                PreY=NextY;
                P=P+1;         
            end
        end
        trace(P+1)=func2(BestX, BestY);
    end
    deta=abs( func2( BestX,BestY)-func2 (PreBestX, PreBestY));
end
disp('最小值在点:');
BestX
BestY
disp( '最小值为:');
func2(BestX, BestY)
plot(trace(2:end))
xlabel('迭代次数')
ylabel('目标函数值')
title('适应度进化曲线')