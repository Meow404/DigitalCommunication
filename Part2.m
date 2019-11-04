SNR = (1:50);
disp(SNR);

count = 100;
finalErrorRate = zeros(1,length(SNR));

for i = 1 : length(SNR)
    totalErrorRate = 0;
    for j = 1 : count
        totalErrorRate = totalErrorRate + Part2_OOK(SNR(i));
    end
    finalErrorRate(i) = totalErrorRate/count;
end

figure();
plot(SNR, finalErrorRate);