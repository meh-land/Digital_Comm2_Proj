% This function takes an array reg and shifts its contents to the right,
% then puts val as the new rightmost value
function newReg = shiftRegister(val, reg)
    newReg = reg;
    for i = 2:length(reg)
        newReg(i) = reg(i-1);
    end
    newReg(1) = val;
end