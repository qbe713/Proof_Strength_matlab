  function [n2_theo_points]=n2_points_filter(n2idxSSF_ma,n2_meand1_ma,n2idxSSF_sg,n2_meand1_sg,n2idxFH,lenF)
n2_theo_points(1)=n2idxSSF_ma;
n2_theo_points(2)=n2_meand1_ma;
n2_theo_points(3)=n2idxSSF_sg;
n2_theo_points(4)=n2_meand1_sg;
n2_theo_points(5)=n2idxFH;
%% filter
rowstodelete= n2_theo_points>(lenF/2);
n2_theo_points(rowstodelete)=[];
n2_theo_points(isnan(n2_theo_points))=[];
end