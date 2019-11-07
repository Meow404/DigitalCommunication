function codeWords = generateCodeWords(data, n, k, type, generator) 


noOfMessages = ceil(size(data,2)/k);
newSize = noOfMessages*n;

codeWords = zeros(1,newSize);

for i = 0:noOfMessages-1
    if nargin ~= 4
        codeWords(n*i+1:n*(i+1)) = encode(data(k*i+1:k*(i+1)), n, k, type, generator);
    else
        codeWords(n*i+1:n*(i+1)) = encode(data(k*i+1:k*(i+1)), n, k, type);
    end
end

end