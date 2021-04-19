function [value] = Extensometer_on_test(vector)
    TF=isnan(vector);
    countNan=sum(TF(:)==1);
    per_of_NaN=countNan/length(vector);
    if per_of_NaN>0.1
        disp('Extensometer not engaged, neglecting measurment vector!')
        value=0;
    else
        vector1=(vector(~isnan(vector)));%removing NaN values
        meanvector=mean(vector1);%mean of all the values after removing Nan
        answer = length(find ( vector1 < 0 ));%number of negative values from array
        per_of_values=(answer/length(vector1))*100;
        disp(['Mean value of given vector is ',num2str(meanvector)]);
        disp([num2str(per_of_values),'% of given vector values are negative'])
        disp(['There are total of ',num2str(answer),' negative values out of ',num2str(length(vector)),' total vector indexes']) 
        if meanvector<0 || per_of_values>50
            disp('Extensometer not engaged, neglecting measurment vector!')
            value=0;
        else 
            disp('Extensometer engaged, measurment is valid, saving data ...')
            value=1;
        end 
    end
    clear vector1 meanvector answer per_of_values TF countNan
end