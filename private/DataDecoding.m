function Data = DataDecoding(receivedData, SIZE, boundry, values)

Data=zeros(1,SIZE);
    for loop_var = 1:SIZE  %This loop makes every 0 into a -1

            if (receivedData(loop_var)<=boundry)
                Data(loop_var)=values(1);
            else
                Data(loop_var)=values(2);
            end        
    end 

end