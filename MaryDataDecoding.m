function Data = MaryDataDecoding(receivedData, SIZE, M)

loop_var=1;
Data=zeros(1,SIZE);
max = M-1;

while loop_var <= SIZE  %This loop makes every 0 into a -1
    
    for boundry = max:-1:0
        if receivedData(loop_var)>sqrt(2*(boundry-0.5))
            Data(loop_var) = boundry;
            break;
        else
            Data(loop_var) = 0;
        end
    end
    loop_var=loop_var+1;
end

end