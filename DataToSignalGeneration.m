function data = DataToSignalGeneration(originalData,SIZE)

loop_var=1;
data=zeros(1,SIZE);
    while loop_var <= SIZE  %This loop makes every 0 into a -1

        if (originalData(loop_var)==0);
            data(loop_var)=-1;
        else
            data(loop_var)= 1;
        end

        loop_var=loop_var+1;
    end
    
end