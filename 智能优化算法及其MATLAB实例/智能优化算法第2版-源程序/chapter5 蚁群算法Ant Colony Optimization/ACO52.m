%%%%%%%%%%%%%%%%%%%%��Ⱥ�㷨������ֵ%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%��ʼ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;               %������б���
close all;               %��ͼ
clc;                     %����
m=20;                    %���ϸ���
G_max=200;               %����������
Rho=0.9;                 %��Ϣ������ϵ��
P0=0.2;                  %ת�Ƹ��ʳ���
XMAX= 5;                 %��������x���ֵ
XMIN= -5;                %��������x��Сֵ
YMAX= 5;                 %��������y���ֵ
YMIN= -5;                %��������y��Сֵ
%%%%%%%%%%%%%%%%%����������ϳ�ʼλ��%%%%%%%%%%%%%%%%%%%%%%
for i=1:m
    X(i,1)=(XMIN+(XMAX-XMIN)*rand);
    X(i,2)=(YMIN+(YMAX-YMIN)*rand);
    Tau(i)=func(X(i,1),X(i,2));
end
step=0.1;                %�ֲ���������
for NC=1:G_max
    lamda=1/NC;
    [Tau_best,BestIndex]=min(Tau);
    %%%%%%%%%%%%%%%%%%����״̬ת�Ƹ���%%%%%%%%%%%%%%%%%%%%
    for i=1:m
        P(NC,i)=(Tau(BestIndex)-Tau(i))/Tau(BestIndex);
    end
    %%%%%%%%%%%%%%%%%%%%%%λ�ø���%%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:m
           %%%%%%%%%%%%%%%%%�ֲ�����%%%%%%%%%%%%%%%%%%%%%%
        if P(NC,i)<P0
            temp1=X(i,1)+(2*rand-1)*step*lamda;
            temp2=X(i,2)+(2*rand-1)*step*lamda;
        else
            %%%%%%%%%%%%%%%%ȫ������%%%%%%%%%%%%%%%%%%%%%%%
             temp1=X(i,1)+(XMAX-XMIN)*(rand-0.5);
             temp2=X(i,2)+(YMAX-YMIN)*(rand-0.5);
        end
        %%%%%%%%%%%%%%%%%%%%%�߽紦��%%%%%%%%%%%%%%%%%%%%%%%
        if temp1<XMIN
            temp1=XMIN;
        end
        if temp1>XMAX
            temp1=XMAX;
        end
        if temp2<YMIN
            temp2=YMIN;
        end
        if temp2>YMAX
            temp2=YMAX;
        end
        %%%%%%%%%%%%%%%%%%�����ж��Ƿ��ƶ�%%%%%%%%%%%%%%%%%%
        if func(temp1,temp2)<func(X(i,1),X(i,2))
            X(i,1)=temp1;
            X(i,2)=temp2;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%������Ϣ��%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:m
        Tau(i)=(1-Rho)*Tau(i)+func(X(i,1),X(i,2));
    end
    [value,index]=min(Tau);
    trace(NC)=func(X(index,1),X(index,2));
end
[min_value,min_index]=min(Tau);
minX=X(min_index,1);                           %���ű���
minY=X(min_index,2);                           %���ű���
minValue=func(X(min_index,1),X(min_index,2));  %����ֵ
figure
plot(trace)
xlabel('��������');
ylabel('��Ӧ��ֵ');
title('��Ӧ�Ƚ�������')