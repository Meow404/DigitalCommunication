SNR = (1:1:25);  %Range of SNR values
count = 10;    %Iterations per SNR value for more accurate result

% Error Rate Vs SNR for [OOK, BPSK, M-Ary(2 bit), BFSK]

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_OOK');
semilogy(SNR, max(10^(-5),finalErrorRate));

title( {'Error Rate Vs SNR';'\fontsize{8}[OOK, BPSK, M-ARY ASK(2 bit), M-ARY PSK(2 bit), BFSK]'},'fontsize',10)
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_BPSK');
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK');
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryPSK');
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_BFSK');
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'OOK','BPSK','M-Ary ASK','M-Ary PSK','BFSK'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

% SNR = (0.25:0.25:50);
% Error Rate Vs SNR for M-Ary ASK [2 bit, 3 bit, 4 bit, 5 bit] encoding

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK', 2, "# of bits", 1,"Amplitude", 0.5, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

title({'Error Rate Vs SNR';'\fontsize{8} M-ARY ASK [2 bit, 3 bit, 4 bit, 5 bit] encoding'})
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 3, "# of bits", 1,"Amplitude", 0.5, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 4, "# of bits", 1,"Amplitude", 0.5, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 5, "# of bits", 1,"Amplitude", 0.5, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'2 bit', '3 bit', '4 bit', '5 bit'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

% Error Rate Vs SNR for M-Ary ASK amplitudes [1, 2, 10, 100] encoding

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK', 2, "# of bits", 1,"Amplitude", 0.5, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

title({'Error Rate Vs SNR';'\fontsize{8} M-ARY ASK amplitudes [1, 2, 10, 100] encoding'})
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, "# of bits", 2,"Amplitude", 0.5, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, "# of bits", 5,"Amplitude", 0.5, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, "# of bits", 10,"Amplitude", 0.5, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'1', '2', '5', '10'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

% Error Rate Vs SNR for M-Ary ASK threshold [0.25, 0.5, 0.75] encoding

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK', 2, "# of bits", 1,"Amplitude", 0.25, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

title({'Error Rate Vs SNR';'\fontsize{8} M-ARY ASK threshold [0.25, 0.5, 0.75] encoding'})
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, "# of bits", 1,"Amplitude", 0.5, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryASK' , 2, "# of bits", 1,"Amplitude", 0.75, "Offset");
semilogy(SNR, max(10^(-5),finalErrorRate));


legend({'0.25', '0.5', '0.75'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

% Error Rate Vs SNR for M-Ary PSK [2 bit, 3 bit, 4 bit, 5 bit] encoding

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryPSK', 2, "# of bits");
semilogy(SNR, max(10^(-5),finalErrorRate));

title({'Error Rate Vs SNR';'\fontsize{8} M-ARY PSK [2 bit, 3 bit, 4 bit, 5 bit] encoding'})
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryPSK' , 3, "# of bits");
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryPSK' , 4, "# of bits");
semilogy(SNR, max(10^(-5),finalErrorRate));

finalErrorRate = SNRTraverse (SNR, count, 'Part2_MaryPSK' , 5, "# of bits");
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'2 bit', '3 bit', '4 bit', '5 bit'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")