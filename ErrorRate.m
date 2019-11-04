function bitErrorRate = ErrorRate(originalData,receivedData, SIZE)


number_of_error=0;
    for loop_var = 1 : SIZE  %This loop makes every 0 into a -1
            if (originalData(loop_var)~=receivedData(loop_var))
                number_of_error=number_of_error+1;
            end        
    end
%disp(number_of_error);    
bitErrorRate=double(number_of_error/SIZE);

end