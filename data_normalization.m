function [norm_data,dl,F]=data_normalization(dl,F)
norm_data=zeros(1,4);
norm_data(1)=min(dl);
norm_data(2)=max(dl);
dl=(dl-norm_data(1))/(norm_data(2)-norm_data(1));
%%
norm_data(3)=min(F);
norm_data(4)=max(F);
F=(F-norm_data(3))/(norm_data(4)-norm_data(3));
end