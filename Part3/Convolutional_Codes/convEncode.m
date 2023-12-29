function encodedBits = convEncode(Bits, RegLength, GenPoly)
    encodedBits = [];
    c = zeros(length(GenPoly));
    reg = zeros(1, RegLength);
    for i = 1:length(Bits)
        reg = shiftRegister(Bits(i), reg);
        c = reg * GenPoly';
        c = mod(c, 2);
        encodedBits = [encodedBits c];
    end
    
end