SIZE = 10240; %Number of bits to be transmitted
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers
SNR = 5; %Signal  to Noise Ratio

Fc = 10000; %Carrier Frequency
Fs = Fc * 16; %Sampling Frequency
index = 1:1000; %Output Range

dataRate = 1000; %Number of bits transfered per second
numberOfSamplesPerBit =  round(Fs/dataRate); %Number of samples per bit
totalNumberOfSamples = round(Fs*SIZE/dataRate); %Total Number of samples to be modulated

%Signal 
signal = DataToSignalGeneration(originalData, SIZE);

%Initialization of Carrier Signal with an array of zeros
carrierSignal = zeros(1,totalNumberOfSamples); 
Loop = 1;

%Loop to obtain sampled cosined values as carrier signal
while(Loop<=totalNumberOfSamples)
carrierSignal(Loop) = 2*pi*(Fc/Fs)*Loop;
Loop = Loop+1;
end

%disp(carrierSignal);

%Multiplication of carrier signal with input signal
replicatedData = repelem(originalData,numberOfSamplesPerBit);
additionalPhase = pi*(replicatedData+1);
modulatedSignal = cos(carrierSignal+additionalPhase);

%disp(modulatedSignal);

figure();
plot(index,modulatedSignal(1:length(index)));

%To generate artificial noise to be added with the modulated signal
noisySignal = NoisySignalGeneration(modulatedSignal, totalNumberOfSamples, SNR);

figure();
plot(index,noisySignal(1:length(index)));

%To Obtain demodulated signal by multiplying with twice the carrier signal
demodulatedSignal = (2*cos(carrierSignal)).*noisySignal;

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
decodedData = DataDecoding(demodulatedData, SIZE, 0,[-1,1]);

%Calculate the bit error rate
errorRate = ErrorRate(signal,decodedData, SIZE);

disp("Error : "+ errorRate);