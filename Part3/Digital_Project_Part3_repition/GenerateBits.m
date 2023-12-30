%% Function Name: GenerateBits
% Inputs:
    %   N_bits:     Number of bits in the sequence
% Outputs:
    %   bit_seq:    The sequence of generated bits
% Description:
    % This function generates a sequence of bits with length equal to N_bits
    
%% Function Implementation
function bit_seq = GenerateBits(N_bits)

    bit_seq=randi([0 1],1,N_bits);

end

