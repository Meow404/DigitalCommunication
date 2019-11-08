function errorRate = Part2_MaryPSK(SNR, showFigures, m)

% To run function type in the following commands in command prompt
% Part2_MaryPSK(5, 0) => Provides error rate for OOK with SNR 5 without figures
% Part2_MaryPSK(5, 1) => Provides error rate for OOK with SNR 5 with figures
% Part2_MaryPSK(5, 0, 3) => Provides error rate for OOK with [SNR 5, # of bits 3] without figures
% Part2_MaryPSK(5, 1, 3) => Provides error rate for OOK with [SNR 5, # of bits 3]  with figures

if(nargin == 2)
    m = 2; %Number of BITS AVAILABLE FOR ENCODING
end

SIZE = 1024; %Number of bits to be transmitted
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers

Fc = 10000; %Carrier Frequency
Fs = Fc * 16; %Sampling Frequency
index = 1:1000; %Output Range

M = 2^m; %Number of ditince amplitude levels for each symbol
newSize = ceil(SIZE/m); %Size of compressed data (data which represent m number of bits eg. 5 = 101, 8 = 111)

dataRate = 1000; %Number of bits transfered per second
numberOfSamplesPerBit =  round(Fs/dataRate); %Number of samples per bit
totalNumberOfSamples = round(Fs*newSize/dataRate); %Total Number of samples to be modulated

%Format data adds additional 0s to the end of the original data array if
%there is a lack of number of bits eg 1024 => 1 bit extra, therefore add 2
%zeros at the end of the array. Therefore new length = 1026
formattedData = FormatData(originalData, SIZE, m);

%Function to compress data eg 1001 = 9
compressedData = CompressData(formattedData,newSize, m);

if(showFigures)
    figure();
    noOfData = ceil(length(index)/numberOfSamplesPerBit);
    stairs(compressedData(1:noOfData));
    title('Data Wave Form');
    ylim([-0.5 M+0.5]);
    xlim([1 noOfData]); 
end

%Initialization of Carrier Signal with an array of zeros
carrierSignal = zeros(1,totalNumberOfSamples);

%Loop to obtain sampled cosined values as carrier signal
for Loop = 1:totalNumberOfSamples
    carrierSignal(Loop) = 2*pi*(Fc/Fs)*(Loop-1);
end

%disp(carrierSignal);

%Multiplication of carrier signal with input signal
replicatedData = repelem(compressedData,numberOfSamplesPerBit);
additionalPhase = (2*pi/M)*(replicatedData+0.5);
modulatedSignal = cos(carrierSignal + additionalPhase);
%disp(modulatedSignal);

if(showFigures)
    figure();
    plot(index,modulatedSignal(index));
    title('Modulated Signal');
    ylim([-1.5 1.5]);
end

%To generate artificial noise to be added with the modulated signal
noisySignal = NoisySignalGeneration(modulatedSignal, totalNumberOfSamples, SNR);

if(showFigures)
    figure();
    plot(index,noisySignal(index));
    title('Received Signal');
end

%To Obtain demodulated signal by multiplying with twice the Cos of carrier
%signal to obtain in phase component and twice the Sin of carrier signal to
%obtain quadrature component
demodulatedSignal1 = (2*cos(carrierSignal)).*noisySignal;
demodulatedSignal2 = (2*sin(carrierSignal)).*noisySignal;

if(showFigures)
    figure();
    plot(index,demodulatedSignal1(index));
    title('Demodulated Signal 1');
    figure();
    plot(index,demodulatedSignal2(index));
    title('Demodulated Signal 2');
end

%To generate a low pass butterworth 6th order filter and obtain filtered signal with
%cutoff frequecy of 0.2
[b,a] = butter(6,0.2);
filteredSignal1 = filtfilt(b,a,demodulatedSignal1);
filteredSignal2 = filtfilt(b,a,demodulatedSignal2);

if(showFigures)
    figure();
    plot(index,filteredSignal1(index));
    title('Filtered Signal 1')
    figure();
    plot(index,filteredSignal2(index));
    title('Filtered Signal 2')
end

%Obtain midpoints from recieved filtered signals
demodulatedData1 = filteredSignal1(numberOfSamplesPerBit/2:numberOfSamplesPerBit:totalNumberOfSamples);
demodulatedData2 = filteredSignal2(numberOfSamplesPerBit/2:numberOfSamplesPerBit:totalNumberOfSamples);

%Find arctan of Y/X => Quadrature component/In phase compnent
phasedData = atan2(demodulatedData2,demodulatedData1);
phasedData = mod((2*pi-phasedData),2*pi);

%Use threshold logic to decode the received signal by setting threshold at different levels
decodedData = MaryPSKDataDecoding(phasedData, newSize, M);

if(showFigures)
    figure();
    noOfData = ceil(length(index)/numberOfSamplesPerBit);
    stairs(decodedData(1:noOfData));
    title('Decoded Signal');
    ylim([-1 M]);
    xlim([1 noOfData]); 
end

%function to decompress data symbols eg. 7 = 111
decompressedData = DecompressData(decodedData,newSize, m);

%Calculate the bit error rate
errorRate = ErrorRate(originalData,decompressedData, SIZE);

end