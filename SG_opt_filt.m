function [F_filter_sg,dl_filter_sg,rmse_sg_filter]=SG_opt_filt(dl,F)
%% SG filter
Sp=0.9999999;

h=length(F)-1;
%wl_start-starting number for different window length, has to be odd
%wl_step-step size for window length vector, has to be 2*n,n can be any
%number, this makes sure that if the starting number is odd any other
%number in array is also odd
if h>10 && h<1000
    wlmax=floor(h/2)
    wl_start=floor(wlmax/10)
    if mod(wl_start,2)==0   
        wl_start=wl_start+1   
    else   
    end
    n=floor(wl_start/2);
    wlstep=2*n;
    wlsg=wl_start:wlstep:wlmax;
    
elseif length(F)>=1000
    wlmax=floor(h/10)
    wl_start=floor(wlmax/10)
    if mod(wl_start,2)==0 
        wl_start=wl_start+1 
    else  
    end
    n=floor(wl_start/2)
    wlstep=2*n
    wlsg=wl_start:wlstep:wlmax
else
    wlsg=1
end
wlsg=wlsg'
rmse_sg=zeros(1,length(wlsg));
idx_sg=zeros(1,length(wlsg));
figure
    for i=1:1:length(wlsg)
  
        F_filt1 = sgolayfilt(F,3,wlsg(i));
        dl_filt1=sgolayfilt(dl,3,wlsg(i));
        
        rmse_sg(i)=(sqrt(mean((F-F_filt1).^2)));
        
        [xData, yData] = prepareCurveData(dl_filt1, F_filt1);
        ft = fittype( 'smoothingspline' );
        
        opts = fitoptions( 'Method', 'SmoothingSpline' );
        
        opts.SmoothingParam=Sp;
        
        [fitresult,~] = fit( xData, yData, ft, opts );
        
        [~,d2] = differentiate(fitresult,dl);
        
        idx_sg(i) = find(d2==min(d2));
        %% Second derivative of fitted curve
        plot(dl,d2,'--','MarkerSize',0.4)
        hold on;
        plot(dl(idx_sg(i)),d2(idx_sg(i)),'x')
        hold on;
        xlabel( 'dl_SG', 'Interpreter', 'none' );
        ylabel( 'd(F)^2/d^2(dl)', 'Interpreter', 'none' );
        
    end
hold off
figure
plot3(wlsg,rmse_sg,idx_sg)
grid on
xlabel('Window Length of filter Savitzkey Golay');ylabel('Root mean square error');zlabel('Index of minimum of Smoothing Spline second derivative')
clear F_filt1 dl_filt1 gof opts d2 ft i xData yData rmse_sg
%% Double treshhold hysteresis
[wlvalue]=double_t_h_hysteresis(idx_sg,wlsg);
clear idx_sg

F_filter_sg=sgolayfilt(F,3,wlvalue);
dl_filter_sg=sgolayfilt(dl,3,wlvalue);

rmse_sg_filter=(sqrt(mean((F-F_filter_sg).^2)));
end