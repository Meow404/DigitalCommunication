function errorRate = Part2_OOK(SNR, showFigures)

% To run function type in the following commands in command prompt
% Part2_OOK(5, 0) => Provides error rate for OOK with SNR 5 without figures
% Part2_OOK(5, 1) => Provides error rate for OOK with SNR 5 with figures

SIZE = 1024; %Number of bits to be transmitted
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers
%SNR = 20; %Signal  to Noise Ratio

Fc = 10000; %Carrier Frequency
Fs = Fc * 16; %Sampling Frequency
index = 1:2000; %Output Range

dataRate = 1000; %Number of bits transfered per second
numberOfSamplesPerBit =  round(Fs/dataRate); %Number of samples per bit
totalNumberOfSamples = round(Fs*SIZE/dataRate); %Total Number of samples to be modulated

if(showFigures)
    figure();
    noOfData = ceil(length(index)/numberOfSamplesPerBit);
    stairs(originalData(1:noOfData));
    title('Data Wave Form');
    ylim([-1 2]);
    xlim([1 noOfData]); 
end

%Initialization of Carrier Signal with an array of zeros
carrierSignal = zeros(1,totalNumberOfSamples);

%Loop to obtain sampled cosined values as carrier signal
for Loop = 1:totalNumberOfSamples
    carrierSignal(Loop) = cos(2*pi*(Fc/Fs)*(Loop-1)+pi/2);
end

%disp(carrierSignal);

%Multiplication of carrier signal with input signal
replicatedData = repelem(originalData,numberOfSamplesPerBit);
modulatedSignal = carrierSignal.*replicatedData;

%disp(modulatedSignal);

if(showFigures)
    figure();
    plot(index,modulatedSignal(index));
    title('Modulated Signal');
end

%To generate artificial noise to be added with the modulated signal
noisySignal = NoisySignalGeneration(modulatedSignal, totalNumberOfSamples, SNR);

if(showFigures)
    figure();
    plot(index,noisySignal(index));
    title('Receieved Signal');
end

%To Obtain demodulated signal by multiplying with twice the carrier signal
demodulatedSignal = (2*carrierSignal).*noisySignal;

if(showFigures)
    figure();
    plot(index,demodulatedSignal(index));
    title('Demodulated Signal');
end

%To generate a low pass butterworth 6th order filter and obtain filtered signal with
%cutoff frequecy of 0.2
[b,a] = butter(6,0.2);
filteredSignal = filtfilt(b,a,demodulatedSignal);

if(showFigures)
    figure();
    plot(index,filteredSignal(index));
    title('Filtered Signal')
end

%Obtain midpoints from recieved filtered signal
receivedData = filteredSignal(numberOfSamplesPerBit/2:numberOfSamplesPerBit:totalNumberOfSamples);

%Use threshold logic to decode the received signal by setting threshold to 0.5
decodedData = DataDecoding(receivedData, SIZE, 0.5,[0,1]);

if(showFigures)
    figure();
    noOfData = ceil(length(index)/numberOfSamplesPerBit);
    stairs(decodedData(1:noOfData));
    title("Decoded Data");
    ylim([-1 2]);
    xlim([1 noOfData]); 
end

%Calculate the bit error rate
errorRate = ErrorRate(originalData,decodedData, SIZE);

%disp("Error : "+ errorRate);
end