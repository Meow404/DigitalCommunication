SIZE = 1024; %Number of bits to be transmitted
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers
SNR = 5; %Signal  to Noise Ratio

Fc = 10000; %Carrier Frequency
Fs = Fc * 4; %Sampling Frequency > 2fc
index = 1:200; %Output Range

dataRate = 1000; %Number of bits transfered per second
numberOfSamplesPerBit =  round(Fs/dataRate); %Number of samples per bit
totalNumberOfSamples = round(Fs*SIZE/dataRate); %Total Number of samples to be modulated

%Signal (-1,1) generated from random original signal (0,1)
signal = DataToSignalGeneration(originalData, SIZE);

%Initialization of Carrier Signal with an array of zeros
carrierSignal = zeros(1,totalNumberOfSamples); 

Loopc = 1;
while(Loopc<=totalNumberOfSamples)
carrierSignal(Loopc) = cos(2*pi*(Fc/Fs)*Loopc);
Loopc = Loopc+1;
end

figure();
plot(index,carrierSignal(1:length(index)));

%Initialization of Modulated Signal with an array of zeros
modulatedSignal = zeros(1,totalNumberOfSamples);

%Replicate the original data
replicatedData = repelem(originalData,numberOfSamplesPerBit);
Loopm = 1;

%Loop to obtain sampled cosined values as carrier signal
while(Loopm<=totalNumberOfSamples)
    if(replicatedData(Loopm)==0)
        modulatedSignal(Loopm) = cos(2*pi*(Fc/Fs)*Loopm);
    else
        modulatedSignal(Loopm) = -cos(2*pi*(Fc/Fs)*Loopm);
    end
    Loopm = Loopm+1;
end

%fprintf("Original Data");
%disp(originalData);
%fprintf("Replicated Data");
%disp(replicatedData);
%fprintf("Modulated Data");
%disp(modulatedSignal);

figure();
plot(index,modulatedSignal(1:length(index)));

%To generate artificial noise to be added with the modulated signal
noisySignal = NoisySignalGeneration(modulatedSignal, totalNumberOfSamples, SNR);

figure();
plot(index,noisySignal(1:length(index)));

%To Obtain demodulated signal by multiplying with twice the carrier signal
demodulatedSignal = (2*(carrierSignal)).*noisySignal;

figure();
plot(index,demodulatedSignal(1:length(index)));

%To generate a low pass butterworth 6th order filter and obtain filtered signal with
%cutoff frequecy of 0.2
[b,a] = butter(6,0.2);
filteredSignal = filtfilt(b,a,demodulatedSignal);

figure();
plot(index,filteredSignal(1:length(index)));

%Obtain midpoints from recieved filtered signal
demodulatedData = filteredSignal(numberOfSamplesPerBit/2:numberOfSamplesPerBit:totalNumberOfSamples);

%Use threshold logic to decode the received signal by setting threshold to 0.5 
decodedData = DataDecoding(demodulatedData, SIZE, 0,[1,-1]);

%Calculate the bit error rate
errorRate = ErrorRate(signal,decodedData, SIZE);

disp("Error : "+ errorRate);