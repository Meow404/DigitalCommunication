SNR = (1:1:25);  %Range of SNR values
count = 10;    %Iterations per SNR value for more accurate result

% Error Rate Vs SNR for [OOK, BPSK, M-Ary(2 bit), BFSK]

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_OOK');
semilogy(SNR, max(10^(-5),finalErrorRate));

title( {'Error Rate Vs SNR';'\fontsize{8}[OOK, OOK w/ linear block code error detection]'},'FontWeight','normal','fontsize',10)
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part3_OOK');
semilogy(SNR, max(10^(-5),finalErrorRate));


legend({'OOK','OOK w/ error detection'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")