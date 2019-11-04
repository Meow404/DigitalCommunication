function errorRate = Part2_Mary(SNR, showFigures)

SIZE = 1024; %Number of bits to be transmitted
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers
m = 2; %Number of BITS AVAILABLE FOR ENCODING

Fc = 10000; %Carrier Frequency
Fs = Fc * 16; %Sampling Frequency
index = 1:2000; %Output Range

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

%Initialization of Carrier Signal with an array of zeros
carrierSignal = zeros(1,totalNumberOfSamples);

%Loop to obtain sampled cosined values as carrier signal
for Loop = 1:totalNumberOfSamples
    carrierSignal(Loop) = cos(2*pi*(Fc/Fs)*(Loop-1)+pi/2);
end

%disp(carrierSignal);

%Multiplication of carrier signal with input signal
replicatedData = repelem(sqrt(2*compressedData),numberOfSamplesPerBit);
modulatedSignal = carrierSignal.*replicatedData;

%disp(modulatedSignal);

if(showFigures)
    figure();
    plot(index,modulatedSignal(1:length(index)));
end

%To generate artificial noise to be added with the modulated signal
noisySignal = NoisySignalGeneration(modulatedSignal, totalNumberOfSamples, SNR);

if(showFigures)
    figure();
    plot(index,noisySignal(1:length(index)));
end

%To Obtain demodulated signal by multiplying with twice the carrier signal
demodulatedSignal = (2*carrierSignal).*noisySignal;

if(showFigures)
    figure();
    plot(index,demodulatedSignal(1:2000));
end

%To generate a low pass butterworth 6th order filter and obtain filtered signal with
%cutoff frequecy of 0.2
[b,a] = butter(6,0.2);
filteredSignal = filtfilt(b,a,demodulatedSignal);

if(showFigures)
    figure();
    plot(index,filteredSignal(1:length(index)));
end

%Obtain midpoints from recieved filtered signal
demodulatedData = filteredSignal(numberOfSamplesPerBit/2:numberOfSamplesPerBit:totalNumberOfSamples);

%Use threshold logic to decode the received signal by setting threshold at different levels
decodedData = MaryDataDecoding(demodulatedData, newSize, M);

%function to decompress data symbols eg. 7 = 111
decompressedData = DecompressData(decodedData,newSize, m);

%disp(originalData(1:21));
%disp(compressedData(1:7));
%disp(decodedData(1:7));
%disp(decompressedData(1:21));

%Calculate the bit error rate
errorRate = ErrorRate(originalData,decompressedData, SIZE);

end