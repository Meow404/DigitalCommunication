function errorRate = Part2_BFSK(SNR, showFigures)

SIZE = 1024; %Number of bits to be transmitted
originalData= randi([0 1],1,SIZE); % This generates an array of random binary numbers

F1 = 500; %Carrier Frequency1
F2 = 2000; %Carrier Frequency2

Fs = F1 * 20; %Sampling Frequency1 Fs = 40

index = 1:400; %Output Range

dataRate = 1000; %Number of bits transfered per second
numberOfSamplesPerBit =  round(Fs/dataRate); %Number of samples per bit  8
totalNumberOfSamples = round(Fs*SIZE/dataRate); %Total Number of samples to be modulated 80

if(showFigures)
    figure();
    noOfData = ceil(length(index)/numberOfSamplesPerBit);
    stairs(originalData(1:noOfData));
    title('Data Wave Form');
    ylim([-1 2]);
    xlim([1 noOfData]); 
end

%Initialization of Carrier Signal with an array of zeros
carrierSignal1 = zeros(1,totalNumberOfSamples);
carrierSignal2 = zeros(1,totalNumberOfSamples);


for Loopc = 1:totalNumberOfSamples
    carrierSignal1(Loopc) = cos(2*pi*(F1/Fs)*(Loopc-1)+pi/2);
    carrierSignal2(Loopc) = cos(2*pi*(F2/Fs)*(Loopc-1)+pi/2);
end

%Initialization of Modulated Signal with an array of zeros
modulatedSignal = zeros(1,totalNumberOfSamples);
Loopm = 1;

%Replicate the original data
replicatedData = repelem(originalData,numberOfSamplesPerBit);

%Loop to obtain sampled cosined values as carrier signal
while(Loopm<=totalNumberOfSamples)
    if(replicatedData(Loopm)==1)
        modulatedSignal(Loopm) = cos(2*pi*(F1/Fs)*(Loopm-1)+pi/2);
    else
        modulatedSignal(Loopm) = cos(2*pi*(F2/Fs)*(Loopm-1)+pi/2);
    end
    Loopm = Loopm+1;
end

%fprintf("Modulated Data");
%disp(modulatedSignal);
%fprintf("Original Data");
%disp(originalData);

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
    title('Receieved Signal');
end

%To Obtain demodulated signal by multiplying with twice the carrier signal
demodulatedSignal1 = (2*carrierSignal1).*noisySignal;
demodulatedSignal2 = (2*carrierSignal2).*noisySignal;

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

%Obtain midpoints from recieved filtered signal
differenceSignal = filteredSignal1-filteredSignal2;

if(showFigures)
    figure();
    plot(index,differenceSignal(1:length(index)));
    title('Difference Signal 2')
end

receivedData = differenceSignal(numberOfSamplesPerBit/2:numberOfSamplesPerBit:totalNumberOfSamples);

%Use threshold logic to decode the received signal by setting threshold to 0.5
decodedData = DataDecoding(receivedData, SIZE, 0,[0,1]);

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

end