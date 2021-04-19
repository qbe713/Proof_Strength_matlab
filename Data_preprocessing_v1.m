function [F,dl,n3,fs,fn] = Data_preprocessing_v1(F,T,dl)
%% Last point deletion
F=F(1:(length(F)-1));
dl=dl(1:(length(dl)-1));
T=T(1:(length(T)-1));
%% First point adjustment
F=F-F(1);
dl=dl-dl(1);
%% Determaning n3 point when the specimen broke
Fmax=max(F);
for n=1:1:length(F)
    if(F(n)>(Fmax-(0.005*Fmax)))
        n3=n;%n3-last point before test specimen failure
    end
end
n=0;
%% Rewriting the data up to n2 point
F=F(1:n3);
dl=dl(1:n3);
fs=(length(T))/(max(T));
fs=round(fs); %fs - sampling freq 
fn=fs/2; %fn-niquist freq
end

