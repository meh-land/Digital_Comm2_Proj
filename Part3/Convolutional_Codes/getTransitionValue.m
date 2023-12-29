function transitionValue = getTransitionValue(r, succ1Row)
    b1 = -1*ones(4, 4);
    b2 = b1;
    b1(1,1) = 0; 
    b1(1,2) = 1; 
    b1(2,3) = 1; 
    b1(2,4) = 0; 
    b1(3,1) = 1; 
    b1(3,2) = 0; 
    b1(4,3) = 0; 
    b1(4,4) = 1; 


    b2(1,1) = 0; 
    b2(1,2) = 0; 
    b2(2,3) = 1; 
    b2(2,4) = 1; 
    b2(3,1) = 1; 
    b2(3,2) = 1; 
    b2(4,3) = 0; 
    b2(4,4) = 0; 

    transitionValue = [b1(r, succ1Row) b2(r, succ1Row)];

end
