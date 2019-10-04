SIZE = 1024;
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers
SNR = 5;
while(SNR<=50)
Data = DataToSignalGeneration(originalData, SIZE);
noisySignal = NoisySignalGeneration(Data, SIZE, SNR);
decodedData = DataDecoding(noisySignal, SIZE, 0);
errorRate = ErrorRate(originalData,decodedData, SIZE,[0,1]);

disp(errorRate);

SNR=SNR + 5;
end