%% Function Name: encoder
% Inputs:
    %   msg
    %   N
    %   k
% Outputs:
    %   u
% Description:
    % This function encodes bit sequence into polar code
    
%% Function Implementation
function u = encoder(msg,N,k)
    % maximum depth + 1
    n = log2(N);  
    % generate reliability sequence
    RS = reliaSeq(N); 
    % initializing
    u = zeros(1,N);
    % putting the message on leftmost channels
    u(RS(N-k+1:end)) = msg; 
    % number of bits to be added per iteration
    m = 1;
    %maximum depth: at the leaf nodes to the 0th depth at the root node
    for d = n-1:-1:0 
       for i = 1:2*m:N  
            a = u(i:i+m-1); %left child
            b = u(i+m:i+2*m-1);%right child
            u(i:i+2*m-1) = [xor(a,b) b];%xor and concatenate
       end
       % as depth decreases number of bits to be operated on increases also
       m = m*2;
    end
end