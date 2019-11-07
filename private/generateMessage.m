function message = generateMessage(data, n, k, parityCheckMatrix)

synTable = mySyndtable(parityCheckMatrix); %reUsed/Copied code to avoid displays

noOfCodeWords = ceil(size(data,2)/n);
newSize = noOfCodeWords*k;
message = zeros(1,newSize);

for i = 0:noOfCodeWords-1
    codeWord = data(n*i+1:n*(i+1));
    error = mod(codeWord*parityCheckMatrix.',2);
    if(sum(error) == 0)
        receivedMessage = codeWord(n-k+1:n);
    else
        decimal =  bi2de(error,'left-msb');
        correct = synTable(decimal+1,:);
        correctedCodeWord = mod(correct + codeWord,2);
        receivedMessage = correctedCodeWord(n-k+1:n);
    end
    message(k*i+1:k*(i+1)) = receivedMessage;
end

end