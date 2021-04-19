function Proof_stress_line_plots(proof_line,dl,F,opt_rp_line)

    i=length(proof_line(1,:));%% how many vectors are there in a matrix
    max_opt_rp_line_idx=find(opt_rp_line<max(F), 1, 'last' );%%index of opt_rp_line that is =max(F),for plot

%% 
    if i==1
        %% min/max idx for selected Proof stress
        min_proof_line_idx=find(abs(proof_line)==min(abs(proof_line)));
        max_proof_line_idx=find(abs(proof_line)<max(F), 1, 'last' );
        %% Plot
        plot(dl,F,'k-');
        hold on
        plot(dl(1:max_opt_rp_line_idx),opt_rp_line(1:max_opt_rp_line_idx),'r--')
        hold on
        plot(dl(min_proof_line_idx:max_proof_line_idx),proof_line(min_proof_line_idx:max_proof_line_idx),'g--')
        hold off
        
        %% clearing space
        clear min_proof_line_idx max_proof_line_idx
    else
        %% min/max idx 0.1 Proof stress

        min_proof_line_idx01=find(abs(proof_line(:,1))==min(abs(proof_line(:,1))));%%index where y=0. (beggining of the plot)
        max_proof_line_idx01=find(abs(proof_line(:,1))<max(F), 1, 'last' );

        %% min/max idx 0.2 Proof stress

        min_proof_line_idx02=find(abs(proof_line(:,end))==min(abs(proof_line(:,end))));%%index where y=0. (beggining of the plot)
        max_proof_line_idx02=find(abs(proof_line(:,end))<max(F), 1, 'last' );

        %% Plots
        plot(dl,F,'k-');
        hold on
        plot(dl(1:max_opt_rp_line_idx),opt_rp_line(1:max_opt_rp_line_idx),'r--')
        hold on
        plot(dl(min_proof_line_idx01:max_proof_line_idx01),proof_line(min_proof_line_idx01:max_proof_line_idx01,1),'g--')
        hold on
        plot(dl(min_proof_line_idx02:max_proof_line_idx02),proof_line(min_proof_line_idx02:max_proof_line_idx02,end),'y--')
        hold off
        
        %% clearing space
        clear min_proof_line_idx01 max_proof_line_idx01 min_proof_line_idx02 max_proof_line_idx02
    end
    clear i max_opt_rp_line_idx
    xlabel('Strain %')
    ylabel('Stress MPa')
    grid on
    hold off
end