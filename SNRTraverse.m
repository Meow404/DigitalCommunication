function finalErrorRate = SNRTraverse(SNR, count, functionName, numOfBits, amplitude, threshold)
%disp(SNR);

%to handle functions other than M-Ary
if(nargin == 3)
    MAry = 0;
else
    MAry = 1;
end

%To implement function name passed
func = str2func(functionName);
finalErrorRate = zeros(1,length(SNR));

%finds error rate for range of SNR, 'count' number of times and averages
%for final result
for i = 1 : length(SNR)
    totalErrorRate = 0;
    for j = 1 : count
        if(~MAry)
            totalErrorRate = totalErrorRate + func(SNR(i), 0);
        else
            totalErrorRate = totalErrorRate + func(SNR(i), 0, numOfBits, amplitude, threshold);
        end
    end
    finalErrorRate(i) = totalErrorRate/count;
end
    
if(~MAry)
    disp(functionName+" ~ DONE");
else
    disp(functionName+" | # of bits : "+numOfBits+" | Amplitude : "+amplitude+" | Threshold : "+threshold+" ~ DONE");
end

end