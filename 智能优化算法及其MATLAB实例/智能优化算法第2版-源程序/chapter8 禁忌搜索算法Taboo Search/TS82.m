%%%%%%%%%%%%%%%%禁忌搜索算法求函数极值问题%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%初始化%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;                        %清除所有变量
close all;                        %清图
clc;                              %清屏
xu=5;                             %上界
xl=-5;                            %下界
L=randint(1,1,[5 11]);            %禁忌长度取5,11之间的随机数
Ca=5;                             %邻域解个数
Gmax=200;                         %禁忌算法的最大迭代次数；
w=1;                              %自适应权重系数
tabu=[];                          %禁忌表
x0=rand(1,2)*(xu-xl)+xl;          %随机产生初始解
bestsofar.key=x0;                 %最优解
xnow(1).key=x0;                   %当前解
%%%%%%%%%%%%%%%%最优解函数值，当前解函数值%%%%%%%%%%%%%%%%%
bestsofar.value=func2(bestsofar.key);  
xnow(1).value=func2(xnow(1).key);
g=1;
while g<Gmax
    x_near=[];                     %邻域解
    w=w*0.998;
    for i=1:Ca
        %%%%%%%%%%%%%%%%%%%%%产生邻域解%%%%%%%%%%%%%%%%%%%%
        x_temp=xnow(g).key;
        x1=x_temp(1);
        x2=x_temp(2);
        x_near(i,1)=x1+(2*rand-1)*w*(xu-xl);
           %%%%%%%%%%%%%%%%%边界条件处理%%%%%%%%%%%%%%%%%%%
           %%%%%%%%%%%%%%%%%%%边界吸收%%%%%%%%%%%%%%%%%%%%%
        if x_near(i,1)<xl
            x_near(i,1)=xl;
        end
        if x_near(i,1)>xu
            x_near(i,1)=xu;
        end
        x_near(i,2)=x2+(2*rand-1)*w*(xu-xl);
           %%%%%%%%%%%%%%%%%边界条件处理%%%%%%%%%%%%%%%%%%%
           %%%%%%%%%%%%%%%%%%%边界吸收%%%%%%%%%%%%%%%%%%%%%
        if x_near(i,2)<xl
            x_near(i,2)=xl;
        end
        if x_near(i,2)>xu
            x_near(i,2)=xu;
        end
        %%%%%%%%%%%%%%计算邻域解点的函数值%%%%%%%%%%%%%%%%%%%
        fitvalue_near(i)=func2(x_near(i,:)); 
    end
    %%%%%%%%%%%%%%%%%%%%最优邻域解为候选解%%%%%%%%%%%%%%%%%%%
    temp=find(fitvalue_near==max(fitvalue_near));
    candidate(g).key=x_near(temp,:);
    candidate(g).value=func2(candidate(g).key);
    %%%%%%%%%%%%%%候选解和当前解的评价函数差%%%%%%%%%%%%%%%%%%
    delta1=candidate(g).value-xnow(g).value; 
    %%%%%%%%%%%%%%候选解和目前最优解的评价函数差%%%%%%%%%%%%%%%
    delta2=candidate(g).value-bestsofar.value;    
    %%%%%候选解并没有改进解，把候选解赋给下一次迭代的当前解%%%%%%
    if delta1<=0   
        xnow(g+1).key=candidate(g).key;
        xnow(g+1).value=func2(xnow(g).key);
        %%%%%%%%%%%%%%%%%%%%%更新禁忌表%%%%%%%%%%%%%%%%%%%%%%%
        tabu=[tabu;xnow(g+1).key];
        if size(tabu,1)>L  
            tabu(1,:)=[];
        end
        g=g+1;                 %更新禁忌表后，迭代次数自增1
    %%%%%%%如果相对于当前解有改进，则应与目前最优解比较%%%%%%%%%%
    else
        if delta2>0            %候选解比目前最优解优
            %%%%%%%%%%把改进解赋给下一次迭代的当前解%%%%%%%%%%%%
            xnow(g+1).key=candidate(g).key;
            xnow(g+1).value=func2(xnow(g+1).key);
            %%%%%%%%%%%%%%%%%%%%更新禁忌表%%%%%%%%%%%%%%%%%%%%%
            tabu=[tabu;xnow(g+1).key];
            if size(tabu,1)>L 
                tabu(1,:)=[];
            end 
            %%%%%%%%把改进解赋给下一次迭代的目前最优解%%%%%%%%%%%%
            %%%%%%%%%%%%%%%%%包含藐视准则%%%%%%%%%%%%%%%%%%%%%%%
            bestsofar.key=candidate(g).key;
            bestsofar.value=func2(bestsofar.key);
            g=g+1;                %更新禁忌表后，迭代次数自增1
        else
            %%%%%%%%%%%%%%%判断改进解时候在禁忌表里%%%%%%%%%%%%%%%
            [M,N]=size(tabu);
            r=0;
            for m=1:M
                if candidate(g).key(1)==tabu(m,1)...
                   & candidate(g).key(2) == tabu(m,1)
                    r=1;
                end
            end
            if  r==0
                %%改进解不在禁忌表里，把改进解赋给下一次迭代的当前解
                xnow(g+1).key=candidate(g).key;
                xnow(g+1).value=func2(xnow(g+1).key);
                %%%%%%%%%%%%%%%%%%%%%更新禁忌表%%%%%%%%%%%%%%%%%%
                tabu=[tabu;xnow(g).key];
                if size(tabu,1)>L
                    tabu(1,:)=[];
                end
                g=g+1;               %更新禁忌表后，迭代次数自增1
            else
                %%%如果改进解在禁忌表里，用当前解重新产生邻域解%%%%%
                xnow(g).key=xnow(g).key;
                xnow(g).value=func2(xnow(g).key);
            end
        end
    end
    trace(g)=func2(bestsofar.key);
end
bestsofar;           %最优变量及最优值
figure
plot(trace);
xlabel('迭代次数')
ylabel('目标函数值')
title('搜索过程最优值曲线')