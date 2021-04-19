function [proof_line]=Proof_stress_line(slope,opt_rp_line)
    flag=true;
    while flag
        prompt = 'Please input [a] or [b] or [c]:';
        disp('Which proof stress do you want master:');
        disp('   - 0.1%-[a] ');
        disp('   - 0.2%-[b] ');
        disp('   - both-[c] ');
        disp('   - none of the above');
        str=input(num2str(prompt),'s');
        proof=[0.1 0.2];%
        if str=='a'
           lx(1)=-proof(1)*slope;
           proof_line=opt_rp_line+lx(1);
           flag=0;
        elseif str=='b'
           lx(2)=-proof(2)*slope;
           proof_line=opt_rp_line+lx(2);
           flag=0;
        elseif str=='c'
            for i=1:length(proof)
                lx(i)=-proof(i)*slope;
                proof_line(:,i)=opt_rp_line+lx(i);
                flag=0;
            end
        else
            prompt = 'If you made a mistake input [Y]/input anything else if your want to end';
            str=input(prompt,'s');
            if str=='Y'
                flag=1;
            else
                flag=0;
            end
        end
    end
clear flag lx i str prompt proof   
end