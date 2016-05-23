%this runs after main_crater
[samples, len] = size(C);
data = reshape(zscore(C)',1,len,samples);
M = 2;%Number of Mixtures
Q = 5;%Number of states
O = 1;%observations
nex = samples; %number of examples
T = len; %Size of the sequence
prior0 = normalise(rand(Q,1));
transmat0 = mk_stochastic(rand(Q,Q));

[mu0, Sigma0] = mixgauss_init(Q*M, reshape(data, [O T*nex]), 'diag');
mu0 = reshape(mu0, [O Q M]);
Sigma0 = reshape(Sigma0, [O O Q M]);
mixmat0 = mk_stochastic(rand(Q,M));

[LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
    mhmm_em(data, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', 100, 'cov_type', 'diag');

sample_numb = 10;
[data, hidden] = mhmm_sample(length(data), sample_numb, prior1, transmat1, mu1, Sigma1, mixmat1); 
data = squeeze(data);
mhmm_logprob(data(1,:,1), prior1, transmat1, mu1, Sigma1, mixmat1)
figure()
plot(mean(data,2))

