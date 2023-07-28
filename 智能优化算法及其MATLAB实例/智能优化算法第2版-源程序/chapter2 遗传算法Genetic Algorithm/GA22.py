####################实值遗传算法求函数极值#####################
###########################初始化#############################
import numpy as np

def func2(x):
    return np.sum(x*x)

D=10;                                #基因数目    
NP=100;                              #染色体数目
Xs=20;                               #上限          
Xx=-20;                              #下限
G=1000;                               #最大遗传代数
f=np.zeros((D,NP));                       #初始种群赋空间
nf=np.zeros((D,NP));                      #子种群赋空间
Pc=0.8;                              #交叉概率
Pm=0.1;                              #变异概率
f=np.random.uniform(Xx,Xs,(D,NP))             #随机获得初始种群
# print(f.shape)
######################按适应度升序排列#######################


MSLL = np.zeros(NP)
for np in range(NP):
    MSLL[np] = func2(f[:,np])
# np.sort(MSLL)
