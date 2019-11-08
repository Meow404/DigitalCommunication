SNR = (1:1:25);  %Range of SNR values
count = 10;    %Iterations per SNR value for more accurate result

% Error Rate Vs SNR for [OOK with Linear Block Coding]

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_OOK');
semilogy(SNR, max(10^(-5),finalErrorRate));

title( {'Error Rate Vs SNR';'\fontsize{8}OOK with Linear Block Coding'},'FontWeight','normal','fontsize',10)
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part3_OOKLinear');
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'None', 'Linear'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

% Error Rate Vs SNR for [OOK with Hamming Encoding]

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_OOK');
semilogy(SNR, max(10^(-5),finalErrorRate));

title( {'Error Rate Vs SNR';'\fontsize{8}OOK with Hamming Encoding'},'FontWeight','normal','fontsize',10)
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part3_OOKHamming');
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'None','Hamming'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

% Error Rate Vs SNR for [OOK with Cyclic Block Coding]

figure();

finalErrorRate = SNRTraverse (SNR, count, 'Part2_OOK');
semilogy(SNR, max(10^(-5),finalErrorRate));

title( {'Error Rate Vs SNR';'\fontsize{8}OOK with Cyclic Block Coding'},'FontWeight','normal','fontsize',10)
xlabel('SNR')
ylabel('Error Rate')
hold on;

finalErrorRate = SNRTraverse (SNR, count, 'Part3_OOKCyclic');
semilogy(SNR, max(10^(-5),finalErrorRate));

legend({'None', 'Cyclic'},'Location','southwest')

disp("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")