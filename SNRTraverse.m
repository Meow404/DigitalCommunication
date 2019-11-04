function finalErrorRate = SNRTraverse(SNR, count, functionName)
%disp(SNR);

func = str2func(functionName);
finalErrorRate = zeros(1,length(SNR));

for i = 1 : length(SNR)
    totalErrorRate = 0;
    for j = 1 : count
        totalErrorRate = totalErrorRate + func(SNR(i), 0);
    end
    finalErrorRate(i) = totalErrorRate/count;
end

disp(functionName+" : DONE");
end