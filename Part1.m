SIZE = 1024000;
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers
SNR = 0;

while(SNR<=50)
Data = DataToSignalGeneration(originalData, SIZE);
noisyData = NoisyDataGeneration(Data, SIZE, SNR);
decodedData = DataDecoding(noisyData, SIZE);
errorRate = ErrorRate(originalData,decodedData, SIZE);

disp(errorRate);

SNR=SNR + 5;
end