#################差分进化算法求函数极值#################
import numpy as np
#########################初始化########################
NP=20;                                #个体数目
D=2;                                  #变量的维数
G=100;                                #最大进化代数
F=0.5;                                #变异算子
CR=0.1;                               #交叉算子
Xs=4;                                 #上限
Xx=-4;                                #下限
#########################赋初值########################
x=np.zeros((D,NP));                        #初始种群
v=np.zeros((D,NP));                        #变异种群
u=np.zeros((D,NP));                        #选择种群
x=np.random.uniform(Xx,Xs,(D,NP))              #赋初值
####################计算目标函数#######################
def func2(x):
    
Ob = np.zeros_like(x)
for m in range(NP):
    Ob[m]=func2(x[:,m])
