SIZE = 1024;
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers

SNR = 5;%0.1:0.1:25;
count = 1000;
finalErrorRate = zeros(1,length(SNR));

% for i = 1:length(SNR)
%     errorRate = 0;
%     for j = 1:count
figure;
stairs(originalData(1:20));
ylim([-0.5 1.5])
xlim([1 20]);

Signal = DataToSignalGeneration(originalData, SIZE);
figure;
stairs(Signal(1:20)); 
ylim([-3 3]);
xlim([1 20]);


noisySignal = NoisySignalGeneration(Signal, SIZE, SNR);
figure;
stairs(Signal(1:20)); 
hold on;
ylim([-3 3]);
xlim([1 20]);
stairs(noisySignal (1:20)); 
legend({'Original Data', 'Noisy Data'},'Location','southwest')

decodedData = DataDecoding(noisySignal, SIZE, 0, [0,1]);
figure;
stairs(decodedData(1:20)); 
ylim([-0.5 1.5])
xlim([1 20]);

errorRate = errorRate+ErrorRate(originalData,decodedData, SIZE);
%     end
%     finalErrorRate(i) = errorRate/count;
% end
%
% figure();
% semilogy(SNR,max(10^(-5),finalErrorRate));
