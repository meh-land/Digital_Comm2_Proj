function succRow = getSuccessorRow(currR, succNum)
    succ1Mem = [1 3 1 3];
    succ2Mem = [2 4 2 4];
    if succNum == 1
        succRow = succ1Mem(currR);
    elseif succNum == 2
        succRow = succ2Mem(currR);
    end  
end