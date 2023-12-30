function pred = getPredecessorRow(r, val)
    predMem = zeros(4, 2);
    predMem(1,1) = 1;
    predMem(2,1) = 1;
    predMem(3,1) = 2;
    predMem(4,1) = 2;
    predMem(1,2) = 3;
    predMem(2,2) = 3;
    predMem(3,2) = 4;
    predMem(4,2) = 4;

    if val == 0
        pred = 0;
    else
        pred = predMem(r, val);
end
