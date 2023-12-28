function sample_seq = GenerateSamples(bit_seq,fs)
%
% Inputs:
%   bit_seq:    Input bit sequence
%   fs:         Number of samples per bit
% Outputs:
%   sample_seq: The resultant sequence of samples
%
% This function takes a sequence of bits and generates a sequence of
% samples as per the input number of samples per bit

    sample_seq = [];

    for index = 1:length(bit_seq)
        if bit_seq(index) == 1
            sample_seq = [sample_seq ones(1, fs)];
        else
            sample_seq = [sample_seq zeros(1, fs)];
        end
    end
end