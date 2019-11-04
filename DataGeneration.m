n=1024;
gen_bin_random= randi([0 1],1,n); % This generates an array of random binary numbers
gen_convert= gen_bin_random;
disp(gen_convert);

for loop_var = 1 : 1024  %This loop makes every 0 into a -1
        
        if (gen_convert(loop_var)==0);
            gen_convert(loop_var)=-1;
        end       
      
end 

noise_gen=randn(1,n); % This is an array of Noise that is normaly distributed

SNR=10; % This is a chosen value of SNR that should be changed to examaine what happens
S=1;
N= S/(10^(SNR/10)) %


trans_noise= (sqrt(N)*noise_gen);
rec_signal= gen_convert+trans_noise;
%disp(rec_signal);

loop_var=1
rec_signal_final=zeros(1,1024);
while loop_var <= 1024  %This loop makes every 0 into a -1
        
        if (rec_signal(loop_var)>0);
            rec_signal_final(loop_var)=1;
        end        
            
        if (rec_signal(loop_var)<0);
            rec_signal_final(loop_var)=0;
            
        end        
           
        loop_var=loop_var+1;
        
        
        
end 


loop_var=1;
number_of_error=0;
while loop_var <= 1024  %This loop makes every 0 into a -1
        
        if (rec_signal_final(loop_var)~=gen_bin_random(loop_var));
            number_of_error=number_of_error+1;
  
            
        end        
           
        loop_var=loop_var+1;
        
end
bit_error_rate=number_of_error/n