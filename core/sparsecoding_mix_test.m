function Z_testmix=sparsecoding_mix_test(Dict,database,opt)
% this function is used for sparse coding for the testing/cv data is mixture
% min norm2(x-Dz)^2+lambda1*norm1(z)

D=Dict.D;
X=database.test_mixdata;

opt.max_iter = 1000;
opt.threshold=1e-5;
opt.showprogress=false; % show the FISTA progress
rng(0)
Zinit=randn(opt.K,size(X,2));

L = max(eig(2*D'*D));  
Z_testmix=fista(Zinit, L, opt.lambda1, opt, @calc_F,@grad);

% cost function
function cost = calc_F(Z)
    cost = calc_f(Z) + opt.lambda1*norm1(Z);
end 
% convex function f
function cost = calc_f(Z)        
    cost =norm((X - D*Z), 'fro')^2; 
end 
% gradiant of f
function g = grad(Z)
    g= 2*D'*(D*Z-X);
end

end % end of the function file