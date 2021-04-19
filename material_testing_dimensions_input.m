function [Stress,Strain]=material_testing_dimensions_input(F,dl)
flag=true;
    while flag
        prompt = 'Is the test specimen rectangular [r] or circular [c]?:';
        disp('r - rectangular');
        disp('c - circular');
        disp('If the input is not r or c, I cannot provide Stress and Strain relationships and will assume there is no measurment data');
        str=input(prompt,'s');
        if str=='r'
            disp('');
            disp('Please use . instead of , as decimal seperator');
            prompt = 'Input thickness in mm, t=';
            t=input(prompt);
            disp('Please use . instead of , as decimal seperator');
            prompt = 'Input width in mm, b=';
            b=input(prompt);
            A=t*b;
            flag=0;
        elseif str=='c'
            disp('');
            disp('Please use . instead of , as decimal seperator');
            prompt = 'Input diameter in mm, b=';
            b=input(prompt);
            A=(pi*(b^2))/4;
            flag=0;
        else
            disp('');
            prompt = 'If your input was wrong input [Y]/input anything else if your want to end: ';
            str=input(prompt,'s');
            A=1;
            if str=='Y'
                flag=true;
            else
                flag=0;
            end
        disp(['Surface area is A=',num2str(A),'mm2']);
        end
    end
A=A;
maxdl=max(dl);
Stress=((F.*1000)./(A));%MPa
prompt = 'Please input original gauge length in mm, L=';
L0=input(prompt);%improve the check if number%

Strain=(dl./L0)*100; 
end

