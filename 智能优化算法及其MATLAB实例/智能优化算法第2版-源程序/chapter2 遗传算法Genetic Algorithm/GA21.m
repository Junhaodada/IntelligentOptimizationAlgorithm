%%%%%%%%%%%%%%%%%%%%��׼�Ŵ��㷨������ֵ%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%��ʼ������%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;              %������б���
close all;              %��ͼ
clc;                    %����
NP=50;                  %��Ⱥ����
L=20;                   %��������������
Pc=0.8;                 %������
Pm=0.1;                 %������
G=100;                  %����Ŵ�����
Xs=10;                  %����
Xx=0;                   %����
f=randi([0,1],NP,L);        %�����ó�ʼ��Ⱥ
%%%%%%%%%%%%%%%%%%%%%%%%%�Ŵ��㷨ѭ��%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:G
    %%%%%%%%%%%%�������ƽ���Ϊ������Χ��ʮ����%%%%%%%%%%%%%%
    for i=1:NP
        U=f(i,:);
        m=0;
        for j=1:L
            m=U(j)*2^(j-1)+m;
        end
        x(i)=Xx+m*(Xs-Xx)/(2^L-1);
        Fit(i)= func1(x(i));
    end
    maxFit=max(Fit);           %���ֵ
    minFit=min(Fit);           %��Сֵ
    rr=find(Fit==maxFit);
    fBest=f(rr(1,1),:);        %�������Ÿ���   
    xBest=x(rr(1,1));
    Fit=(Fit-minFit)/(maxFit-minFit);  %��һ����Ӧ��ֵ
    %%%%%%%%%%%%%%%%%%�������̶ĵĸ��Ʋ���%%%%%%%%%%%%%%%%%%%
    sum_Fit=sum(Fit);
    fitvalue=Fit./sum_Fit;
    fitvalue=cumsum(fitvalue);
    ms=sort(rand(NP,1));
    fiti=1;
    newi=1;
    while newi<=NP
        if (ms(newi))<fitvalue(fiti)
            nf(newi,:)=f(fiti,:);
            newi=newi+1;
        else
            fiti=fiti+1;
        end
    end   
    %%%%%%%%%%%%%%%%%%%%%%���ڸ��ʵĽ������%%%%%%%%%%%%%%%%%%
    for i=1:2:NP
        p=rand;
        if p<Pc
            q=randi([0,1],1,L);
            for j=1:L
                if q(j)==1
                    temp=nf(i+1,j);
                    nf(i+1,j)=nf(i,j);
                    nf(i,j)=temp;
                end
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%���ڸ��ʵı������%%%%%%%%%%%%%%%%%%%%%%%
    i=1;
    while i<=round(NP*Pm)
        h=randi([1,NP],1,1);      %���ѡȡһ����Ҫ�����Ⱦɫ��
        for j=1:round(L*Pm)         
            g=randi([1,L],1,1);   %�����Ҫ����Ļ�����
            nf(h,g)=~nf(h,g);
        end
        i=i+1;
    end
    f=nf;
    f(1,:)=fBest;                   %�������Ÿ���������Ⱥ��
    trace(k)=maxFit;                %����������Ӧ��
end
xBest;                              %���Ÿ���
figure
plot(trace)
xlabel('��������')
ylabel('Ŀ�꺯��ֵ')
title('��Ӧ�Ƚ�������')

