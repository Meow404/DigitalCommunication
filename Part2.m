SNR = (0.1:0.1:25);
count = 100;

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_OOK');
semilogy(SNR, max(10^(-5),finalErrorRate));

title('Error Rate Vs SNR for [OOK, BPSK, M-Ary, BFSK]')
xlabel('SNR') 
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_BPSK');
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_Mary');
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_BFSK');
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'OOK','BPSK','M-Ary','BFSK'},'Location','southwest')