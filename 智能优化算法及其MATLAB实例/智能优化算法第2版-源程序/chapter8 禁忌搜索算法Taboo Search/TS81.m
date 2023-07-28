%%%%%%%%%%%%%%%%%%%%%���������㷨���TSP����%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%��ʼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;                        %������б���
close all;                        %��ͼ 
clc;                              %����
C = [1304 2312;3639 1315;4177 2244;3712 1399;3488 1535;3326 1556;...
    3238 1229;4196 1044;4312  790;4386  570;3007 1970;2562 1756;...
    2788 1491;2381 1676;1332  695;3715 1678;3918 2179;4061 2370;...
    3780 2212;3676 2578;4029 2838;4263 2931;3429 1908;3507 2376;...
    3394 2643;3439 3201;2935 3240;3140 3550;2545 2357;2778 2826;...
    2370 2975];                   %31��ʡ���������
N=size(C,1);                      %TSP����Ĺ�ģ,��������Ŀ
D=zeros(N);                       %�����������о���������
%%%%%%%%%%%%%%%%%%%%%�������������о���������%%%%%%%%%%%%%%%%%%%%%
for i=1:N
    for j=1:N
        D(i,j)=((C(i,1)-C(j,1))^2+...
            (C(i,2)-C(j,2))^2)^0.5;
    end
end
Tabu=zeros(N);                      %���ɱ�
TabuL=round((N*(N-1)/2)^0.5);       %���ɳ���
Ca=200;                             %��ѡ���ĸ���(ȫ����������)
CaNum=zeros(Ca,N);                  %��ѡ�⼯��
S0=randperm(N);                     %���������ʼ��
bestsofar=S0;                       %��ǰ��ѽ�
BestL=Inf;                          %��ǰ��ѽ����
figure(1);
p=1;
Gmax=1000;                          %����������   
%%%%%%%%%%%%%%%%%%%%%%%%%%%��������ѭ��%%%%%%%%%%%%%%%%%%%%%%%%%%
while p<Gmax
    ALong(p)=func1(D,S0);            %��ǰ������ֵ
    %%%%%%%%%%%%%%%%%%%%%%%%%%%��������%%%%%%%%%%%%%%%%%%%%%%%%%%
    i=1;
    A=zeros(Ca,2);                   %���н����ĳ��о���
    %%%%%%%%%%%%%%%%%��������н����ĳ��о���%%%%%%%%%%%%%%%%%%%%%
    while i<=Ca
        M=N*rand(1,2);
        M=ceil(M);         
        if M(1)~=M(2)
            A(i,1)=max(M(1),M(2));
            A(i,2)=min(M(1),M(2));
            if i==1
                isa=0;
            else
                for j=1:i-1
                    if A(i,1)==A(j,1) && A(i,2)==A(j,2)
                        isa=1;
                        break;
                    else
                        isa=0;
                    end
                end
            end
            if ~isa
                i=i+1;
            else
            end
        else
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%���������%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%����ǰBestCaNum����ú�ѡ��%%%%%%%%%%%%%%%%%%%
    BestCaNum=Ca/2;
    BestCa=Inf*ones(BestCaNum,4);
    F=zeros(1,Ca);
    for i=1:Ca
        CaNum(i,:)=S0;
        CaNum(i,[A(i,2),A(i,1)])=S0([A(i,1),A(i,2)]);
        F(i)=func1(D,CaNum(i,:));
        if i<=BestCaNum
            BestCa(i,2)=F(i);
            BestCa(i,1)=i;
            BestCa(i,3)=S0(A(i,1));
            BestCa(i,4)=S0(A(i,2));
        else
            for j=1:BestCaNum
                if F(i)<BestCa(j,2)
                    BestCa(j,2)=F(i);
                    BestCa(j,1)=i;
                    BestCa(j,3)=S0(A(i,1));
                    BestCa(j,4)=S0(A(i,2));
                    break;
                end
            end
        end
    end
    [JL,Index]=sort(BestCa(:,2));
    SBest=BestCa(Index,:);
    BestCa=SBest;
    %%%%%%%%%%%%%%%%%%%%%%%%����׼��%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if BestCa(1,2)<BestL
        BestL=BestCa(1,2);
        S0=CaNum(BestCa(1,1),:);
        bestsofar=S0;
        for m=1:N
            for n=1:N
                if Tabu(m,n)~=0
                    Tabu(m,n)=Tabu(m,n)-1;    
                    %���½��ɱ�
                end
            end
        end
        Tabu(BestCa(1,3),BestCa(1,4))=TabuL;
        %���½��ɱ�
    else
        for  i=1:BestCaNum
            if  Tabu(BestCa(i,3),BestCa(i,4))==0
                S0=CaNum(BestCa(i,1),:);
                for m=1:N
                    for n=1:N
                        if Tabu(m,n)~=0
                            Tabu(m,n)=Tabu(m,n)-1;
                            %���½��ɱ�
                        end
                    end
                end
                Tabu(BestCa(i,3),BestCa(i,4))=TabuL;
                %���½��ɱ�
                break;
            end
        end
    end
    ArrBestL(p)=BestL;
    p=p+1;   
    for i=1:N-1
        plot([C(bestsofar(i),1),C(bestsofar(i+1),1)],...
            [C(bestsofar(i),2),C(bestsofar(i+1),2)],'bo-');
        hold on;
    end
    plot([C(bestsofar(N),1),C(bestsofar(1),1)],...
        [C(bestsofar(N),2),C(bestsofar(1),2)],'ro-');
    title(['�Ż���̾���:',num2str(BestL)]);
    hold off;
    pause(0.005);
end
BestShortcut=bestsofar;            %���·��
theMinDistance=BestL;              %���·�߳���
figure(2);
plot(ArrBestL); 
xlabel('��������')
ylabel('Ŀ�꺯��ֵ')
title('��Ӧ�Ƚ�������')

