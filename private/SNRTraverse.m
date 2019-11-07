function finalErrorRate = SNRTraverse(SNR, count, functionName, param1, param1Name, param2, param2Name, param3, param3Name)
%disp(SNR);

if(nargin ~= 3 && nargin ~= 5 && nargin ~= 7 && nargin ~= 9)
    return;
end

%To implement function name passed
func = str2func(functionName);
finalErrorRate = zeros(1,length(SNR));

%finds error rate for range of SNR, 'count' number of times and averages
%for final result
for i = 1 : length(SNR)
    totalErrorRate = 0;
    for j = 1 : count
        if(nargin == 3)
            totalErrorRate = totalErrorRate + func(SNR(i), 0);
        elseif(nargin == 5)
            totalErrorRate = totalErrorRate + func(SNR(i), 0, param1);
        elseif(nargin == 7)
            totalErrorRate = totalErrorRate + func(SNR(i), 0, param1, param2);
        else
            totalErrorRate = totalErrorRate + func(SNR(i), 0, param1, param2, param3 );
        end
    end
    finalErrorRate(i) = totalErrorRate/count;
end

if(nargin == 3)
    disp(functionName+" ~ DONE");
elseif(nargin == 5)
    disp(functionName+" | "+param1Name+" : "+param1+" ~ DONE");
elseif(nargin == 7)
    disp(functionName+" | "+param1Name+" : "+param1+" | "+param2Name+" : "+param2+" ~ DONE");
else
    disp(functionName+" | "+param1Name+" : "+param1+" | "+param2Name+" : "+param2+" | "+param3Name+" : "+param3+" ~ DONE");
end

end