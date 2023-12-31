%% Function Name: BEC
% Inputs:
    %   sample_seq:     The input sample sequence to the channel
    %   fs:             The sampling frequency used to generate the sample sequence
    %   p:              The bit flipping probability
% Outputs:
    %   rec_sample_seq: The sequence of sample sequence after passing through the channel
% Description:
    % This function takes the sample sequence passing through the channel, and
    % generates the output sample sequence based on the specified channel type
    % and parameters
    
%% Function Implementation
function rec_sample_seq  = BEC(sample_seq,fs,p)

    sample_seq      = ~~sample_seq;
    rec_sample_seq  = zeros(size(sample_seq));
    rec_sample_seq  = ~~rec_sample_seq;

    if (nargin <= 3)
        channel_type = 'independent';
    end

    switch channel_type
        case 'independent'
            channel_effect = rand(size(rec_sample_seq))<=p;
        case 'correlated'
            channel_effect = rand(1,length(rec_sample_seq)/fs)<=p;
            channel_effect = repmat(channel_effect,fs,1);
            channel_effect = channel_effect(:)';
    end

    rec_sample_seq(channel_effect) = -1;
    rec_sample_seq = rec_sample_seq + 0;
    
end