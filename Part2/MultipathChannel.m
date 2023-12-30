function h = MultipathChannel(L)
% How to use:
%
% h = MultipathChannel(L,N) - generates a matrix h of dimention LxL, where
% each column corresponds to L channel coefficients for L paths

h_l = randn(L,1) + 1i*randn(L,1);  % Complex gaussian

power_profile = exp(-0.5*[0:L-1])';

h_l = abs(h_l).*power_profile;

h = zeros(L,L);

for n = 1:L
    h(:,n) = [ zeros(n-1,1); h_l(1:L-n+1,1) ];
end
