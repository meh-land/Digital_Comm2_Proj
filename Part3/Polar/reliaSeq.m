%% Function Name: reliaSeq
% Inputs:
    %   NF
% Outputs:
    %   Avec
% Description:
    % This function generates the approximate reliability sequence
    
%% Function Implementation
function Avec = reliaSeq(NF)
    pF = log2(NF);
    % initial sequence for N=2
    A = {1;2}; 
    % iterations for each N until reaching desired number of channels for specified NF
    for k = 2:pF  
        N = 2^k;
        p = log2(N);
        Aprev = A;
        A = {1};
        for i = 1:p-1
            z = nchoosek(p-1,p-i);
            B = zeros(z,1);
            AI = cell2mat(Aprev(i+1));
            AI2 = cell2mat(Aprev(p-i+1));
            for j = 1:z
                B(j) = (N+1-AI2(z-j+1));
            end
            res = [AI B'];
            A = [A {res}];
        end
        A = [A {N}];
    end
    Avec = []; %now to convert the cell to a vector
    L = length(A);
    for i = 1:L
        Avec = [Avec cell2mat(A(i))];
    end
end