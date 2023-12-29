function dominantValue = getDominant(nodeValue)
    nodeR = real(nodeValue);
    nodeI = imag(nodeValue);
    if nodeR < 0 && nodeI < 0
        dominantValue = nodeValue;
    elseif nodeR >= 0 && nodeI < 0
        dominantValue = nodeR;
    elseif nodeR < 0 && nodeI >= 0
        dominantValue = nodeI * 1i;
    elseif nodeR >= 0 && nodeI >= 0 && nodeR < nodeI
        dominantValue = nodeR;
    elseif nodeR >= 0 && nodeI >= 0 && nodeI < nodeR
        dominantValue = nodeI * 1i;
    end
end