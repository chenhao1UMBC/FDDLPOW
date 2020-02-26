
clear
clc

dynamic_ratio = [0, 3, 6, 10, 20];  
SNR_INF = 2000;
cvortest = 0;

r_zf = cell(3, 2, 10, 3);
r_mf = r_zf; r_lr = r_zf; r_nn = r_zf;

for mixture_n = 1:3
for indd = [1,5]
    pctrl.db = dynamic_ratio(indd); % dynamic ratio is 0 3, 6, 10, 20 db
    if mixture_n == 3  pctrl.if2weak = 1; else pctrl.if2weak = 0; end
    if pctrl.db == 0     pctrl.equal = 1; else    pctrl.equal = 0; end
    if mixture_n == 3 && pctrl.db == 0  pctrl.if2weak = 0; end
    Database = load_data_new(mixture_n, SNR_INF, pctrl, 1000);
    
for f = 1000:1009
for alg = 1:3

    if alg == 1 && f<1005
        load(['dict1_k25_lmbd0.01_mu0.1_Q10_rng',num2str(f),'.mat']);
        load('B_X_Y_dict1.mat')
        load('NN_dict1.mat')
        if mixture_n ~= 1   opts.lambda1 = 0.01/8;end
        disp(opts.Dictnm); 
        
        run calc_M
        Z = sparsecoding(Dict, Database, opts, mixture_n, 0);
        Z = aoos(Z, Database.featln, size(Z, 2));
        wtz = W'*Z; %(W'*aoos(Z, featln, N));
        H = W'*M;
        
        % ZF detector
        r_zf{mixture_n, indd, f-999, alg} = pinv(H)*wtz;

        % matched filter
        r_mf{mixture_n, indd, f-999, alg} = H'*wtz;

        %neural networks
        r_nn{mixture_n, indd, f-999, alg} = net(wtz);

        %logistic regression classifier
        pre_prob = mnrval(B, wtz');
        r_lr{mixture_n, indd, f-999, alg} = pre_prob';
    end
    
    
    if alg == 2 && f<1005
        load(['dict2_k25_lmbd0.1_mu0.001_Q20_nu10_rng',num2str(f),'.mat']);
        load('B_X_Y_dict2.mat')
        load('NN_dict2.mat')
        if mixture_n ~= 1  opts.lambda1 = 0.035; else opts.lambda1 = 0.05;end
        disp(opts.Dict2nm); 
        
        run calc_M
        Z = sparsecoding(Dict, Database, opts, mixture_n, 0);
        Z = aoos(Z, Database.featln, size(Z, 2));
        wtz = W'*Z; %(W'*aoos(Z, featln, N));
        H = W'*M;
        
        % ZF detector
        r_zf{mixture_n, indd, f-999, alg} = pinv(H)*wtz;

        % matched filter
        r_mf{mixture_n, indd, f-999, alg} = H'*wtz;

        %neural networks
        r_nn{mixture_n, indd, f-999, alg} = net(wtz);

        %logistic regression classifier
        pre_prob = mnrval(B, wtz');
        r_lr{mixture_n, indd, f-999, alg} = pre_prob';
    end
    
    
    if alg == 3 && f>1004
        load(['dict3_k25_lmbd0.1_mu0.001_Q20_nu10_beta1_rng',num2str(f),'.mat']);
        load('B_X_Y_dict3.mat')
        load('NN_dict3.mat')
        if mixture_n ~= 1  opts.lambda1 = 0.015; else opts.lambda1 = 0.02; end
        disp(opts.Dict3nm); 
        
        run calc_M
        Z = sparsecoding(Dict, Database, opts, mixture_n, 0);
        Z = aoos(Z, Database.featln, size(Z, 2));
        wtz = W'*Z; %(W'*aoos(Z, featln, N));
        H = W'*M;
        
        % ZF detector
        r_zf{mixture_n, indd, f-999, alg} = pinv(H)*wtz;

        % matched filter
        r_mf{mixture_n, indd, f-999, alg} = H'*wtz;

        %neural networks
        r_nn{mixture_n, indd, f-999, alg} = net(wtz);

        %logistic regression classifier
        pre_prob = mnrval(B, wtz');
        r_lr{mixture_n, indd, f-999, alg} = pre_prob';
    end
    
end
end
end
end

data_structure = ['3 by 2 by 10 by 3 by 6*450 cell, mixture_n = 1:3,'...
    'dynamic_ratio = [0, 20], f = 1000:1009, alg = 1:3'];
save('L_unknown.mat','r_zf', 'r_mf',  'r_nn','r_lr','data_structure');
figure;