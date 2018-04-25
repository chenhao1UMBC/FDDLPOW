% tatal_dat is training, testing and cv pure data
total_dat = zeros(fre_resol, featln * (cvttln + trln) * nClass);
for ii = 1:nClass
    fname = [dir sig_name{ii}];
    obj=matfile(fname);
    len_window = floor(smp_len/t_resol);

    for k = 1:cvttln + trln
        x = obj.x(((1+(k-1)*smp_len/2):smp_len +(k-1)*smp_len/2),1);
        sp_x = spectrogram(x,len_window,[],fre_resol,4e7,'yaxis','centered');
        temp = log(abs(sp_x));
        total_dat(:, (1+(k-1)*featln) + featln*(cvttln+trln)*(ii-1):...
            k*featln + featln*(cvttln+trln)*(ii-1)) = temp/norm(temp, 'f');  
    end
end
save('total_dat','total_dat')

% mixture data part
N_c = 2;
cv_mixdat=[];tt_mixdat=[];cvmixls=[];ttmixls=[];
c = combnk(1:6, N_c); % ble bt fhss1 zb
for indx_p = 1:N_c
    for indCl=1:size(c,1)
        
        
    end
end

N_c = 3;
cv_mixdat=[];tt_mixdat=[];cvmixls=[];ttmixls=[];
c = combnk(1:6, N_c); % ble bt fhss1 zb
for indx_p = 1:N_c
    for indCl=1:size(c,1)
        
        
    end
end