%function decompresses decimal values depending on number of
%bits available for encoding to binary data. (eg. if m = 3, 101 = 5)
%How? 101 => 5%2 => 1 (5/2)%2 = 0 ((5/2)/2)%2 = 1

function decompressedData = DecompressData(decodedData,newSize, m)
decompressedData = zeros(1,m*newSize);

loop = 1;
while(loop<=newSize)
    value = decodedData(loop);
    for index = m:-1:1
    decompressedData(m*(loop-1)+index) = mod(value,2);
    value = floor(value /2);
    end
    loop=loop+1;
end

%disp(originalData(1:21));
%disp(compressedData(1:7));
end