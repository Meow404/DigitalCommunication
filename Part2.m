SNR = (1:1:25);  %Range of SNR values
count = 10;    %Iterations per SNR value for more accurate result

% Error Rate Vs SNR for [OOK, BPSK, M-Ary(2 bit), BFSK]

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_OOK');
semilogy(SNR, max(10^(-5),finalErrorRate));

title('Error Rate Vs SNR for [OOK, BPSK, M-ARY ASK(2 bit), BFSK]')
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_BPSK');
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK');
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_BFSK');
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'OOK','BPSK','M-Ary','BFSK'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

%SNR = (0.25:0.25:50);
% Error Rate Vs SNR for M-Ary[2 bit, 3 bit, 4 bit, 5 bit] encoding

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK', 2, 1, 0.5);
semilogy(SNR, max(10^(-5),finalErrorRate));

title('Error Rate Vs SNR for M-ARY ASK [2 bit, 3 bit, 4 bit, 5 bit] encoding')
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 3, 1, 0.5);
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 4, 1, 0.5);
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 5, 1, 0.5);
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'2 bit', '3 bit', '4 bit', '5 bit'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

% Error Rate Vs SNR for M-Ary amplitudes [1, 2, 10, 100] encoding

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK', 2, 1, 0.5);
semilogy(SNR, max(10^(-5),finalErrorRate));

title('Error Rate Vs SNR for M-ARY ASK amplitudes [1, 2, 10, 100] encoding')
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, 2, 0.5);
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, 5, 0.5);
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, 10, 0.5);
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'1', '2', '5', '10'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

% Error Rate Vs SNR for M-Ary threshold [0.25, 0.5, 0.75] encoding

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK', 2, 1, 0.25);
semilogy(SNR, max(10^(-5),finalErrorRate));

title('Error Rate Vs SNR for M-ARY ASK threshold [0.25, 0.5, 0.75] encoding')
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, 1, 0.5);
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, 1, 0.75);
semilogy(SNR, max(10^(-5),finalErrorRate));


legend({'0.25', '0.5', '0.75'},'Location','southwest')