SIZE = 1024;
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers

SNR =0.1:0.1:25;
count = 1000;
finalErrorRate = zeros(1,length(SNR));

for i = 1:length(SNR)
    errorRate = 0;
    for j = 1:count
        Data = DataToSignalGeneration(originalData, SIZE);
        noisySignal = NoisySignalGeneration(Data, SIZE, SNR(i));
        decodedData = DataDecoding(noisySignal, SIZE, 0, [0,1]);
        errorRate = errorRate+ErrorRate(originalData,decodedData, SIZE);
    end
    finalErrorRate(i) = errorRate/count;
end

figure();
semilogy(SNR,max(10^(-5),finalErrorRate));
