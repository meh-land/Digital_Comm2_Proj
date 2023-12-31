%% Function Name: ComputeBER
% Inputs:
    %   bit_seq:     The input bit sequence
    %   rec_bit_seq: The output bit sequence
% Outputs:
    %   BER:         Computed BER
% Description:
    % This function takes the input and output bit sequences and computes the
    % BER

%% Function Implementation
function BER = ComputeBER(bit_seq,rec_bit_seq)

    counter = 0;
    l = length(bit_seq);

    for i = 1:1:l
        if bit_seq(i) ~= rec_bit_seq(i)
        counter = counter + 1;
        end
    end
    
    BER = counter / length(bit_seq);
    
end

