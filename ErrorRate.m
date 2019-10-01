function bitErrorRate = ErrorRate(originalData,receivedData, SIZE)

loop_var=1;
number_of_error=0;
    while loop_var <= SIZE  %This loop makes every 0 into a -1
            if (originalData(loop_var)~=receivedData(loop_var))
                number_of_error=number_of_error+1;
            end        

            loop_var=loop_var+1;
    end
disp(number_of_error);    
bitErrorRate=double(number_of_error/SIZE);

end