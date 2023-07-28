%%%%%%%%%%%%%%%�Ŵ��㷨���0-1��������%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%��ʼ������%%%%%%%%%%%%%%%%%%%%%%
clear all;                       %�����
close all;                       %��ͼ
clc;                             %����
NP = 50;                         %��Ⱥ��ģ
L = 10;                          %��Ʒ����
Pc = 0.8;                        %������
Pm = 0.05;                       %������
G = 100;                         %����Ŵ�����
V = 300;                             %��������
C = [95,75,23,73,50,22,6,57,89,98];  %��Ʒ���
W = [89,59,19,43,100,72,44,16,7,64]; %��Ʒ��ֵ
afa = 2;                             %�ͷ�����ϵ��
f = randint(NP,L);                   %�����ó�ʼ��Ⱥ
%%%%%%%%%%%%%%%%%%%%%�Ŵ��㷨ѭ��%%%%%%%%%%%%%%%%%%%%%
for k = 1:G
    %%%%%%%%%%%%%%%%%%��Ӧ�ȼ���%%%%%%%%%%%%%%%%%
    for i = 1:NP
         Fit(i) = func4(f(i,:),C,W,V,afa);
    end
    maxFit = max(Fit);                          %���ֵ
    minFit = min(Fit);                          %��Сֵ
    rr = find(Fit==maxFit);
    fBest = f(rr(1,1),:);                       %�������Ÿ���
    Fit = (Fit - minFit)/(maxFit - minFit);     %��һ����Ӧ��ֵ
    %%%%%%%%%%%%%%�������̶ĵĸ��Ʋ���%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%%%���ڸ��ʵĽ������%%%%%%%%%%%%%
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
    %%%%%%%%%%%%%���ڸ��ʵı������%%%%%%%%%%%%%%
    for m = 1:NP
        for n = 1:L
            r = rand(1,1);
            if r < Pm
                nf(m,n) = ~nf(m,n);
            end
        end
    end
    f = nf;
    f(1,:) = fBest;                     %�������Ÿ���������Ⱥ��
    trace(k) = maxFit;                  %����������Ӧ��
end
fBest;                                  %���Ÿ���
figure
plot(trace)
xlabel('��������')
ylabel('Ŀ�꺯��ֵ')
title('��Ӧ�Ƚ�������')
