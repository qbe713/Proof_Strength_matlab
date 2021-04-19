function [F_filter,dl_filter,rmse_ma_filter]=MA_opt_filt(dl,F)
Sp=0.9999999;
%% MAvg filter
%wlma-window length moving average, wlmax-maximum windows length
h=length(F);
if length(F)>10 && length(F)<1000
    wlmax=floor(length(F)/2);
    wlma=floor(wlmax/10):floor(wlmax/10):wlmax;
elseif length(F)>=1000
    wlmax=floor(length(F)/10);
    wlma=floor(wlmax/10):floor(wlmax/10):wlmax;
else
    wlma=1;
end

wlma=wlma';

rmse_ma=zeros(1,length(wlma));
idx_ma=zeros(1,length(wlma));

figure
    for i=1:1:length(wlma)
        
        kernel=ones(wlma(i),1)/wlma(i);
        F_filter=filter(kernel, 1, F);
        dl_filter=filter(kernel, 1, dl);
        
        rmse_ma(i)=(sqrt(mean((F-F_filter).^2)));
        
        [xData, yData] = prepareCurveData(dl_filter, F_filter);
        ft = fittype( 'smoothingspline' );
        
        opts = fitoptions( 'Method', 'SmoothingSpline' );
        
        opts.SmoothingParam=Sp;
        
        [fitresult,~] = fit( xData, yData, ft, opts );
        
        [~,d2] = differentiate(fitresult,dl);
        
        idx_ma(i) = find(d2==min(d2));
        %% Second derivative of fitted curve
        plot(dl,d2,'--','MarkerSize',0.4)
        hold on;
        plot(dl(idx_ma(i)),d2(idx_ma(i)),'x')
        hold on;
        xlabel( 'dl_Mavg', 'Interpreter', 'none' );
        ylabel( 'd(F)^2/d^2(dl)', 'Interpreter', 'none' );

    end
hold off
figure
plot3(wlma,rmse_ma,idx_ma)
grid on;
xlabel('Window Length of Moving average filter');ylabel('Root mean square error');zlabel('Index of minimum of Smoothing Spline second derivative')
clear kernel F_filter dl_filter gof opts d2 ft i xData yData rmse
%% Double treshhold hysteresis
[wlvalue]=double_t_h_hysteresis(idx_ma,wlma);
clear idx
%% Applying the filter to data
kernel=ones(wlvalue,1)/wlvalue;
F_filter=filter(kernel, 1, F);
dl_filter=filter(kernel, 1, dl);

rmse_ma_filter=(sqrt(mean((F-F_filter).^2)));

end