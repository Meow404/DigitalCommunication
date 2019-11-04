function data = DataToSignalGeneration(originalData,SIZE)

data=zeros(1,SIZE);
    for loop_var = 1 : SIZE  %This loop makes every 0 into a -1

        if (originalData(loop_var)==0);
            data(loop_var)=-1;
        else
            data(loop_var)= 1;
        end
    end
    
end