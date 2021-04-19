function [n2idxFH] = Filter_heuristic_v1(F,dl,fs)

%% Checking the divisibility of the data for averaging
n3=(length(F)-1);%n3-how much data do we need to take into account that division of length of data vector F and step is intiger
while true
    k=check_division(n3);
        if k==0
            n3=n3-1;    
        else
            break
        end
end
step=k;
clear k
%% Creating the array fs more - filter values in Hz from Niquist freq to value larger then 0
len=10;%len=18
fsmore=zeros(1,len);
r=3;%r=3
    for ifs=1:1:len

        fsmore(ifs)=fs./(ifs*r);

    end
clear r ifs
%% Rounding up fsmore values 

fsmore=round(fsmore,2,'significant');

%% Filter Heuristic
for i=1:1:length(fsmore)

%% Filtering all the values

    %% Lowpass data filtering 

    F2=lowpass(F,fsmore(i),fs);
    dl2=lowpass(dl,fsmore(i),fs);

    %% Derivative of the filtered data
    slope_F2=zeros((length(F2)-1),1);
    for n=2:1:length(F2)
        
        slope_F2(n-1)=(F2(n)-F2(n-1))./(dl2(n)-dl2(n-1));
        
    end
    n=0;

    %% Averaging every "h-step" data
    
    Avg_slopeF2=zeros((n3/step),1);
    z=1;
    for h=1:step:(length(slope_F2)-step)
        Avg_slopeF2(z)=mean(slope_F2(h:1:(h+step)));
        z=z+1;
    end
    h=0;
    
    %% Finding points smaller then the mean value of derivative
    
    Mean_slope_F2=mean(slope_F2);
    indexnotation=zeros(length(fsmore),length(Avg_slopeF2));
    for i2=1:1:length(Avg_slopeF2)
        
        if Avg_slopeF2(i2)<Mean_slope_F2 
            
            indexnotation(i,i2)=i2;
            
        end
    end
    i2=0;
    
end
clear i2 i  Mean_slope_F2 h  slope_F2  dl2 Avg_slopeF2 F2 z n3

%% Writing all the non zero values into nzer

nzer=zeros((size(indexnotation,1)),(size(indexnotation,2)));

for i=1:1:(size(indexnotation,1))
    for n=1:1:(size(indexnotation,2))
        if (indexnotation(i,n)~=0)
            nzer(i)=indexnotation(i,n);
            break
        end
    end
end
clear indexnotation i n 

%% Taking into consideration only values larger then 10

nzer=nzer(nzer>=10);

%% Median of all the "good" values

Median_nzer=median(nzer);
clear nzer

%% Real index

n2idxFH=Median_nzer*step;%n2idxFH-n2 point for filter heuristic
clear Median_nzer step

end