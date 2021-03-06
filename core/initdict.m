<<<<<<< HEAD
function [D, Z, W, U, V, delta, Loss, opt]=initdict(X,trlabels,opt)
% This fucntio is to initialize Dictionary
% The input is  X, the training data, a matrix M by N, N data samples
%             trlabels is the labels of training data, like[1,1,1,1,2,2,3,3,3]             
%             opt are the training options with
%                 opt.K -the number of atoms in Dictionary
%                 opt.Q -the projected dimensions
%                 opt.lambda1 -lambda1 control the sparsity level
%                 opt.mu -mu the coeffecient for fisher term
%                 opt.max_iter - the maximum iteration
%                 opt.losscalc -if true then calculate loss fucntion
% The output is Dict, a struct with D,W,Z, Loss(the loss function value)

C=max(trlabels); % how many classes
[M_d,N]=size(X); % M is the data dimension, N is the # of samples
rng(opt.rng)

% check checking the existing Dictionary
opts = opt;
nm = ['FDDLOW_mix','_k',num2str(opts.K),'_lmbd',num2str(opts.lambda1),...
    '_mu',num2str(opts.mu),'_Q',num2str(opts.Q),'_nu',num2str(opts.nu),...
    '_beta',num2str(-1),'.mat' ];
fileexistance=exist(nm);
if fileexistance==2
    load(nm)
    D=Dict_mix.D;
    Z=Dict_mix.Z;
    W=Dict_mix.W;
    [H1, ~, H3] = getMH1H2H3(trlabels, Z);
    delta = 1; 
    U = Dict_mix.U;   
    opt.max_iter = 70;% because of good initialization
    Loss=zeros(3,opt.max_iter); 
else    
    D=randn(M_d,opt.K);
    Z=randn(opt.K,N);
    W=randn(opt.K,opt.Q);
    [H1, ~, H3] = getMH1H2H3(trlabels, Z);
    delta = 1;
    U = mix_updateU(W, Z*H3);
    Loss=zeros(3,opt.max_iter);
end 
    [~, N]=size(Z);
    M1 = eye(N) - H1;
    Y = M1*Z'*W; 
    V = mix_updateV(Y, delta);
    
    
=======
function [D,Z,W,Loss,opt]=initdict(X,trlabels,opt)
% This fucntio is to initialize Dictionary
% The input is  X, the training data, a matrix M by N, N data samples
%             trlabels is the labels of training data, like[1,1,1,1,2,2,3,3,3]             
%             opt are the training options with
%                 opt.K -the number of atoms in Dictionary
%                 opt.Q -the projected dimensions
%                 opt.lambda1 -lambda1 control the sparsity level
%                 opt.mu -mu the coeffecient for fisher term
%                 opt.max_iter - the maximum iteration
%                 opt.losscalc -if true then calculate loss fucntion
% The output is Dict, a struct with D,W,Z, Loss(the loss function value)

C=max(trlabels); % how many classes
[d, N]=size(X); % M is the data dimension, N is the # of samples
rng(opt.rng)

ind = randperm(N);
% D=X(:, ind(1:opt.K));
D = randn(d, opt.K);
Z=randn(opt.K,N);
W=randn(opt.K,opt.Q);
% M = getM_t2(trlabels, Z);
Loss=zeros(1,opt.max_iter);


>>>>>>> 08ff3a0449afe53e0af4a7d7a9b2855ed5c36fcc
end % end of function file