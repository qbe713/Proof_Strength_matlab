function [opt_rp_line,slope]=Optimal_line_fit_v2_AG(F,dl,n2_theo_points)
    for j=1:1:length(n2_theo_points)

        n=1:1:n2_theo_points(j);
        for i=1:1:length(n)
            fit=@(x)fitline2(x,dl,F,n(i));
            x0=1;
            bestfit(i)= fminsearch(fit,x0);
            error(i)=(sum(abs(F(1:n(i))-(bestfit(i)*dl(1:n(i))))))/n(i);
            error2(i)=sqrt(sum((F(1:n(i))-(bestfit(i)*dl(1:n(i)))).^2)/n(i));
        end
        Medianerror1=(median(error));
        Medianerror2=(median(error2));
        
        mat1=(abs(error-Medianerror1));
        min_mat1=(min(mat1));
        opt_idx_abs_error=find(mat1==min_mat1);%optimal index for absolute difference error
        bestlineabs(j)=bestfit(opt_idx_abs_error(1));
        least_err_abs(j)=error(opt_idx_abs_error(1));
        
        mat2=(abs(error2-(median(error2))));
        min_mat2=(min(mat2));
        opt_idx_rs_error=find(mat2==min_mat2);%optimal index for root square error
        bestliners(j)=bestfit(opt_idx_rs_error(1));
        least_err_rs(j)=error2(opt_idx_rs_error(1));
        
        clear n error error 2 Medianerror1 Medianerror2 mat1 mat2 min_mat1 min_mat2
    end
%%
    bestline=[bestlineabs,bestliners];
    clear bestlineabs besliers

    least_err=[least_err_abs,least_err_rs];
    minbestlineIDX=find(least_err==min(least_err));
    clear least_err_abs least_err_abs

%%  
    slope=bestline(minbestlineIDX);1
    
    opt_rp_line=dl*slope;
    clear bestlineabs besliers least_err_abs least_err_abs j
end

