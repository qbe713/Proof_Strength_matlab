function [n2idxSSF,n2_meand1] = Smooth_Spline_fit_v2(F,dl)
Sp=0.9999999;

%% Smoothing Cubic Spline fitting of the given curve

[xData, yData] = prepareCurveData( dl, F );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam=Sp;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

%% Smoothing Spline Derivatives

[d1,d2] = differentiate(fitresult,dl);
meand1=mean(d1);
for i=1:1:length(d1)
    if(d1(i)>2*meand1) && d1(i)>0
        n2_meand1=i;%n2_meand1- last point before derivative goes into mean values
    end
end
idx = find(d2==min(d2));
n2idxSSF=idx;%n2idxSSF-n2 point for Smoothing Spline fit

%% Plott of fitted curve, first der, second der

    %% Fitted Curve

    subplot(3,1,1);
    h = plot(fitresult,'b-',xData, yData,'k-');
    hold on;
    plot(dl(idx),F(idx),'rx')
    hold on;
    plot(dl(n2_meand1),F(n2_meand1),'bx')
    hold off
    legend( 'F vs. dl', 'Smoothing spline fit 1','Last data point d^2','Last good point before mean','Location', 'NorthEast', 'Interpreter', 'none' );
    xlabel( 'dl', 'Interpreter', 'none' );ylabel( 'F', 'Interpreter', 'none' );
    xlim([0 dl(length(dl))]); ylim([0 max(F)]);
    grid on

    %% First derivative of fitted curve

    subplot(3,1,2);
    plot(dl,d1,'k-','MarkerSize',0.4)
    hold on;
    plot(dl(idx),d1(idx),'rx')
    hold on;
    plot(dl(n2_meand1),d1(n2_meand1),'bx')
    hold off
    xlabel( 'dl', 'Interpreter', 'none' );ylabel( 'd(F)/d(dl)', 'Interpreter', 'none' );
    xlim([0 dl(length(dl))]); ylim([min(d1) max(d1)]);

    %% Second derivative of fitted curve

    subplot(3,1,3);
    plot(dl,d2,'k-','MarkerSize',0.4)
    hold on;
    plot(dl(idx),d2(idx),'rx')
    hold on;
    plot(dl(n2_meand1),d2(n2_meand1),'bx')
    hold off
    xlabel( 'dl', 'Interpreter', 'none' );ylabel( 'd(F)^2/d^2(dl)', 'Interpreter', 'none' );
    xlim([0 dl(length(dl))]); ylim([min(d2) max(d2)]);
clear h idx i meand1 d1 d2 fitresult opts ft xData yData Sp
end