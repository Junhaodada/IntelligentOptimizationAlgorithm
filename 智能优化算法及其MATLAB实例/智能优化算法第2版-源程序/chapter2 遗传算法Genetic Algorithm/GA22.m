%%%%%%%%%%%%%%%%%%%%ʵֵ�Ŵ��㷨������ֵ%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%��ʼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;                           %������б���
close all;                           %��ͼ
clc;                                 %����
D=10;                                %������Ŀ    
NP=100;                              %Ⱦɫ����Ŀ
Xs=20;                               %����          
Xx=-20;                              %����
G=1000;                               %����Ŵ�����
f=zeros(D,NP);                       %��ʼ��Ⱥ���ռ�
nf=zeros(D,NP);                      %����Ⱥ���ռ�
Pc=0.8;                              %�������
Pm=0.1;                              %�������
f=rand(D,NP)*(Xs-Xx)+Xx;             %�����ó�ʼ��Ⱥ
%%%%%%%%%%%%%%%%%%%%%%����Ӧ����������%%%%%%%%%%%%%%%%%%%%%%%
for np=1:NP
    MSLL(np)=func2(f(:,np));
end
[SortMSLL,Index]=sort(MSLL);                            
Sortf=f(:,Index);
%%%%%%%%%%%%%%%%%%%%%%%�Ŵ��㷨ѭ��%%%%%%%%%%%%%%%%%%%%%%%%%%
for gen=1:G
    %%%%%%%%%%%%%%���þ�����������ѡ�񽻲����%%%%%%%%%%%%%%%%
    Emper=Sortf(:,1);                      %����Ⱦɫ��
    NoPoint=round(D*Pc);                   %ÿ�ν����ĸ���
    PoPoint=randint(NoPoint,NP/2,[1 D]);   %��������λ��
    nf=Sortf;
    for i=1:NP/2
        nf(:,2*i-1)=Emper;
        nf(:,2*i)=Sortf(:,2*i);
        for k=1:NoPoint
            nf(PoPoint(k,i),2*i-1)=nf(PoPoint(k,i),2*i);
            nf(PoPoint(k,i),2*i)=Emper(PoPoint(k,i));
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%�������%%%%%%%%%%%%%%%%%%%%%%%%%
    for m=1:NP
        for n=1:D
            r=rand(1,1);
            if r<Pm
                nf(n,m)=rand(1,1)*(Xs-Xx)+Xx;
            end
        end
    end
    %%%%%%%%%%%%%%%%%%%%%����Ⱥ����Ӧ����������%%%%%%%%%%%%%%%%%%
    for np=1:NP 
          NMSLL(np)=func2(nf(:,np));   
    end
    [NSortMSLL,Index]=sort(NMSLL);           
    NSortf=nf(:,Index);
    %%%%%%%%%%%%%%%%%%%%%%%%%��������Ⱥ%%%%%%%%%%%%%%%%%%%%%%%%%%
    f1=[Sortf,NSortf];                %�Ӵ��͸����ϲ�
    MSLL1=[SortMSLL,NSortMSLL];       %�Ӵ��͸�������Ӧ��ֵ�ϲ�
    [SortMSLL1,Index]=sort(MSLL1);    %��Ӧ�Ȱ���������
    Sortf1=f1(:,Index);               %����Ӧ�����и���
    SortMSLL=SortMSLL1(1:NP);         %ȡǰNP����Ӧ��ֵ
    Sortf=Sortf1(:,1:NP);             %ȡǰNP������
    trace(gen)=SortMSLL(1);           %����������Ӧ��ֵ
end
Bestf=Sortf(:,1);                     %���Ÿ��� 
trace(end)                            %����ֵ
figure
plot(trace)
xlabel('��������')
ylabel('Ŀ�꺯��ֵ')
title('��Ӧ�Ƚ�������')