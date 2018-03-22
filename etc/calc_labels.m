function [acc_weak, acc_weak_av, acc_all] = calc_labels(labels_pre, opts)
    n = opts.n;
    C = opts.C;
    Ncombs = opts.Ncombs;
    ln_test = opts.ln_test;
    
    acc_t = zeros(C, n);
    % run mix_ntable
    for section = 1:n    
        sect = labels_pre(:,1+(section-1)*ln_test/n:section*ln_test/n);
        % we only care about lower power accurcy
        [acc_t(:,section)] = mix_table_power(ln_test/n, section, sect, Ncombs);
    end

    % this fucntion is shared data funcion to calc each portion of power
    function [acc0] = mix_table_power(ln_test_part, whichpart, labels_pre_part, Ncombs)            
        c = combnk(1:6,n); 
        acc0=zeros(C,1); % only score for true-positive and true negative
        for indCl=1:Ncombs
            temp = c(indCl,:);
            indClnm(1) = temp(whichpart);
            indClnm(2:6) = Theother3(indClnm(1)); % find non-week signal
            for ii=1:ln_test_part/Ncombs          
                    acc0(indClnm(1))=acc0(indClnm(1))+length(find...
                        (labels_pre_part(1:n,ii+(indCl-1)*ln_test_part/Ncombs)==indClnm(1)));            
            end

        end   

    end
    
    acc_weak = sum(acc_t, 2)/50/size(combnk(1:5,n-1),1);
    acc_weak_av = sum(acc_weak)/C;
    acc_all = 0;
    
    
end % end of the function file