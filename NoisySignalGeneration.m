function NoisyData = NoisySignalGeneration(Data, SIZE, SNR)

noise_gen=randn(1,SIZE); % This is an array of Noise that is normaly distributed

S=1;
N= S/(10^(SNR/10)); 

trans_noise = (sqrt(N)*noise_gen);
NoisyData = Data + trans_noise;

end