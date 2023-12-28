function rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,fs)
%
% Inputs:
%   rec_sample_seq: The input sample sequence to the channel
%   case_type:      The sampling frequency used to generate the sample sequence
%   fs:             The bit flipping probability
% Outputs:
%   rec_sample_seq: The sequence of sample sequence after passing through the channel
%
% This function takes the sample sequence after passing through the
% channel, and decodes from it the sequence of bits based on the considered
% case and the sampling frequence


        samples_length = length(rec_sample_seq);
        bits_length = samples_length / fs;
        rec_bit_seq = zeros(1, bits_length);
        
        for bits_ind = 1:bits_length
            samples_index = fs * bits_ind - (fs - 1);
            window = rec_sample_seq(samples_index : samples_index + fs-1);
            window_avg = sum(window)/fs;
            rec_bit_seq(bits_ind) = (window_avg >= 0.5) * 1;
        end
 
