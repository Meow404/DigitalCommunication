function formatData = FormatData(data, size, m)
lastIndex = size;
extra = mod(lastIndex,m);
if(extra>0)
    data = [data,zeros(1,m-extra)];
end
formatData = data;
end