function message = generateMessage(data, n, k, type, generator, synd)

noOfCodeWords = ceil(size(data,2)/n);
newSize = noOfCodeWords*k;
message = zeros(1,newSize);

for i = 0:noOfCodeWords-1
    codeWord = data(n*i+1:n*(i+1));
    if(nargin == 4)
        receivedMessage = decode(codeWord, n, k, type);
    elseif(nargin == 5)
        receivedMessage = decode(codeWord, n, k, type, generator);
    else
        receivedMessage = decode(codeWord, n, k, type, generator, synd);
    end
    message(k*i+1:k*(i+1)) = receivedMessage;
end

end