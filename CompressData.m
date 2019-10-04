%function compresses binary data to decimal values depending on number of
%bits available for encoding. (eg. if m = 3, 5 = 101)
%How? 101 => 1*(2^2) + 0*(2^1) + 1*(2^0) = 5

function compressedData = CompressData(originalData,newSize, m)
compressedData = zeros(1,newSize);

loop = 1;
while(loop<=newSize)
    for pow = 0:m-1
        compressedData(loop) =compressedData(loop) + originalData(m*loop-pow)*(2^pow);
    end
    loop=loop+1;
end

%disp(originalData(1:21));
%disp(compressedData(1:7));
end