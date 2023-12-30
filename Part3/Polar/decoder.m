%% Function Name: decoder
% Inputs:
    %   u
    %   N
    %   k
% Outputs:
    %   msgcap
% Description:
    % This function decodes polar code
    
%% Function Implementation
function msgcap = decoder(u,N,k)
    n=log2(N);
    % same initializations as in encoder
    RS=reliaSeq(N); 
    % here defining the indexes of frozen bits will be useful
    F=RS(1:N-k); 
    % estimated decoded message will be in the leftmost bits
    ucap=zeros(n+1,N); 

    % decoder
    %initializing the belief vector for each depth
    L=zeros(n+1,N); 
    %node state vector. 0 means unactivated, 1 means L is finished, 2 means R, 3 means U.
    ns=zeros(1,2*N-1); 
    node=0;
    %starting at root
    depth=0;
    %received signal act as beliefs (belief of root)
    L(1,:)=u;
    decoded=0; 

    f = @(a,b) (1-2*sign(a)).*(1-2*sign(b)).*min(abs(a),abs(b));
    g = @(a,b,c) b+(1-2*c).*a;
    
    % predefining the functions for ease of use
    % keep going until decoded
    while (decoded == 0) 
        % if leaf node start making decisions
        if depth == n 
            if (any(F == node+1))
               ucap(n+1, node+1)=0;
            else
                if (L(n+1, node+1)>=0)
                    ucap(n+1,node+1)=0;
                else
                    ucap(n+1,node+1)=1;
                end
            end
            % if last node then decoding is finished
            if (node == N-1) 
                decoded = 1;
            else
                % if not keep going and go up in depth
                node = floor(node/2);
                depth = depth - 1;
            end
        % if not leaf node
        else 
            npos = (2^depth-1) + node+1; % position of node in node state vector
        if ns(npos) == 0 %not leaf; state zero, must do "f" function then send to left child
            val=2^(n-depth);%length of incoming belief vector
            Ln=L(depth+1,val*node+1:val*(node+1)); %beliefs from parent
            a=Ln(1:val/2); %left half
            b=Ln(val/2+1:end);%right half
            node=node*2; %next node which will be the
            depth=depth+1;%left child
            val=val/2;%the next one will be halved
            L(depth+1,val*node+1:val*(node+1))=f(a,b);%carry out minsum and store
            ns(npos)=1;%change state of current node to 1 (L done)
        else
            if ns(npos)==1 %previously state 1 node means now it is entering state 2
            val=2^(n-depth); %length of beliefs
            Ln=L(depth+1,val*node+1:val*(node+1)); %incoming beliefs
            a=Ln(1:val/2); 
            b=Ln(val/2+1:end); %splitting to halves
            lnode=node*2; %left child
            ldepth=depth+1;%left child node
            lval=val/2; %length of beliefs of next node
            ucapn=ucap(ldepth+1,lval*lnode+1:lval*(lnode+1)); %incoming decisions
                                                           %from the left child
            node=node*2+1; %next node
            depth=depth+1;%right child
            val=val/2;
            L(depth+1,val*node+1:val*(node+1))=g(a,b,ucapn); %g and storage
            ns(npos)=2;
            else %finished step R, now entering step U and go to parent
               val=2^(n-depth);
               lnode=node*2; %left child
                rnode=node*2+1; %right child
            cdepth=depth+1;
            cval=val/2;
            ucapl=ucap(cdepth+1,cval*lnode+1:cval*(lnode+1)); %incoming decisions from left
            ucapr=ucap(cdepth+1,cval*rnode+1:cval*(rnode+1));%incomign decisions from right
            ucap(depth+1,val*node+1:val*(node+1))=[xor(ucapl,ucapr) ucapr]; %xor and concatenation
            node=floor(node/2); %go to parent
                depth=depth-1;%parent's depth
            end
        end
        end
    end

    msgcap=ucap(n+1,RS(N-k+1:end)); %assign the message from rightmost bits
end