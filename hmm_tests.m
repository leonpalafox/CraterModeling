O = 1;%observations
nex = 2; %number of examples
T = 100; %Size of the sequence
t = 0:0.001:2;
x = sin(2*pi*t);
data = create_data(x, T ,nex);
break
M = 2;
Q = 10;
prior0 = normalise(rand(Q,1));
transmat0 = mk_stochastic(rand(Q,Q));

[mu0, Sigma0] = mixgauss_init(Q*M, reshape(data, [O T*nex]), 'full');
mu0 = reshape(mu0, [O Q M]);
Sigma0 = reshape(Sigma0, [O O Q M]);
mixmat0 = mk_stochastic(rand(Q,M));

[LL, prior1, transmat1, mu1, Sigma1, mixmat1] = ...
    mhmm_em(x, prior0, transmat0, mu0, Sigma0, mixmat0, 'max_iter', 100);

sample_numb = 10;
data = mhmm_sample(length(x), sample_numb, prior1, transmat1, mu1, Sigma1, mixmat1); 
data = squeeze(data);
mhmm_logprob(data(1,:,1), prior1, transmat1, mu1, Sigma1, mixmat1)
figure()
plot(mean(data))
