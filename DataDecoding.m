function Data = DataDecoding(receivedData, SIZE, boundry)

loop_var=1
Data=zeros(1,SIZE);
    while loop_var <= SIZE  %This loop makes every 0 into a -1

            if (receivedData(loop_var)>boundry)
                Data(loop_var)=1;
            else
                Data(loop_var)=0;
            end        
            loop_var=loop_var+1;
    end 
    
end