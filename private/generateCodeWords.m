function codeWords = generateCodeWords(data, n, k, generatorMatrix)

noOfMessages = ceil(size(data,2)/k);
newSize = noOfMessages*n;

codeWords = zeros(1,newSize);

for i = 0:noOfMessages-1
    codeWords(n*i+1:n*(i+1)) = mod(data(k*i+1:k*(i+1))*generatorMatrix,2); 
end

end