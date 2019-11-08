function errorRate = Part3_OOKLinear(SNR, showFigures, n, k)

% To run function type in the following commands in command prompt
% Part3_OOKLinear(5, 0) => Provides error rate for OOK with SNR 5 without figures
% Part3_OOKLinear(5, 1) => Provides error rate for OOK with SNR 5 with figures
% Part3_OOKLinear(5, 0, 8, 4) => Provides error rate for OOK with [SNR 5, n 8, k 4] without figures
% Part3_OOKLinear(5, 1, 8, 4) => Provides error rate for OOK with [SNR 5, n 8, k 4] with figures

if(nargin == 2)
    n = 7;
    k = 4;
end

SIZE = 1024; %Number of bits to be transmitted
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers
%SNR = 20; %Signal  to Noise Ratio

Fc = 10000; %Carrier Frequency
Fs = Fc * 16; %Sampling Frequency
index = 1:200; %Output Range

newSize = ceil(SIZE/k)*n;

dataRate = 1000; %Number of bits transfered per second
numberOfSamplesPerBit =  round(Fs/dataRate); %Number of samples per bit
totalNumberOfSamples = round(Fs*newSize/dataRate); %Total Number of samples to be modulated

%Format data adds additional 0s to the end of the original data array if
%there is a lack of number of bits eg 1024 => 1 bit extra, therefore add 2
%zeros at the end of the array. Therefore new length = 1026
formattedData = FormatData(originalData, SIZE, k);

polynomial = cyclpoly(n,k);
parmat = cyclgen(n,polynomial);
generatorMatrix = gen2par(parmat);

codeWords = generateCodeWords(formattedData, n, k, 'linear/binary', generatorMatrix);

%disp(size(formattedData(1:7*k)));
%disp(size(codeWords));


%Initialization of Carrier Signal with an array of zeros
carrierSignal = zeros(1,totalNumberOfSamples);

%Loop to obtain sampled cosined values as carrier signal
for Loop = 1:totalNumberOfSamples
    carrierSignal(Loop) = cos(2*pi*(Fc/Fs)*(Loop-1)+pi/2);
end

%disp(carrierSignal);

%Multiplication of carrier signal with input signal
replicatedData = repelem(codeWords,numberOfSamplesPerBit);
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
    plot(index,demodulatedSignal(1:length(index)));
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
receivedData = filteredSignal(numberOfSamplesPerBit/2:numberOfSamplesPerBit:totalNumberOfSamples);

%Use threshold logic to decode the received signal by setting threshold to 0.5
decodedData = DataDecoding(receivedData, newSize, 0.5,[0,1]);

message = generateMessage(decodedData, n, k, 'linear/binary', generatorMatrix);

% disp(originalData(1:10))
% disp(message(1:10))
% disp(originalData(11:20))
% disp(message(11:20))
% disp(originalData(21:30))
% disp(message(21:30))

%Calculate the bit error rate
errorRate = ErrorRate(originalData,message, SIZE);

%disp("Error : "+ errorRate);
end