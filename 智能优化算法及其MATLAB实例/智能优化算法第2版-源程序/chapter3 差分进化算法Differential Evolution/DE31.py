import numpy as np
import matplotlib.pyplot as plt
plt.rcParams["font.sans-serif"]=["SimHei"] #设置字体
plt.rcParams["axes.unicode_minus"]=False #该语句解决图像中的“-”负号的乱码问题
def func1(x):
    # 根据具体的目标函数定义实现函数体
    return np.sum(x**2) # 示例: 目标函数为每个变量的平方和

def de_algorithm():
    # 初始化参数
    NP = 50      # 个体数目
    D = 10       # 变量的维数
    G = 200      # 最大进化代数
    F0 = 0.4     # 初始变异算子
    CR = 0.1     # 交叉算子
    Xs = 20      # 上限
    Xx = -20     # 下限
    yz = 1e-6    # 阈值

    # 赋初值
    x = np.random.uniform(low=Xx, high=Xs, size=(D, NP))

    # 计算目标函数
    Ob = np.zeros(NP)
    for m in range(NP):
        Ob[m] = func1(x[:, m])
    trace = [np.min(Ob)]

    # 差分进化循环
    for gen in range(G):
        # 变异操作
        lamda = np.exp(1 - G / (G + 1 - gen))
        F = F0 * 2**lamda

        v = np.zeros((D, NP))
        for m in range(NP):
            r = np.random.choice(np.arange(NP), size=3, replace=False)
            while r[0] == m or r[1] == m or r[2] == m:
                r = np.random.choice(np.arange(NP), size=3, replace=False)
            v[:, m] = x[:, r[0]] + F * (x[:, r[1]] - x[:, r[2]])

        # 交叉操作
        r = np.random.randint(0, D)
        u = np.where(np.random.rand(D, NP) <= CR, v, x)
        u[r, :] = v[r, :]

        # 处理边界条件
        u = np.clip(u, Xx, Xs)

        # 选择操作
        Ob1 = np.zeros(NP)
        for m in range(NP):
            Ob1[m] = func1(u[:, m])
            if Ob1[m] < Ob[m]:
                x[:, m] = u[:, m]

        Ob = np.copy(Ob1)
        trace.append(np.min(Ob))

        if np.min(Ob) < yz:
            break

    SortOb = np.sort(Ob)
    Index = np.argsort(Ob)
    x = x[:, Index]
    X = x[:, 0]
    Y = np.min(Ob)
    print("X={}".format(X))
    print("Y={}".format(Y))

    # 画图
    plt.plot(trace)
    plt.xlabel('迭代次数')
    plt.ylabel('目标函数值')
    plt.title('适应度进化曲线')
    plt.show()

de_algorithm()
