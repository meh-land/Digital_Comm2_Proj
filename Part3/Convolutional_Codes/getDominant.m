function [pred, dominantValue]= getDominant(nodeValue)
    nodeR = real(nodeValue);
    nodeI = imag(nodeValue);
    pred = 0;
    dominantValue = 0;
    if nodeR < 0 && nodeI < 0
        dominantValue = nodeValue;
        pred = 0;
    elseif nodeR >= 0 && nodeI < 0
        dominantValue = nodeR;
        pred = 1;
    elseif nodeR < 0 && nodeI >= 0
        dominantValue = nodeI * 1i;
        pred = 2;
    elseif nodeR >= 0 && nodeI >= 0 && nodeR < nodeI
        dominantValue = nodeR;
        pred = 1;
    elseif nodeR >= 0 && nodeI >= 0 && nodeI < nodeR
        dominantValue = nodeI * 1i;
        pred = 2;
    end
end