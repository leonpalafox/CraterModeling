function out_data = create_data(data, size_segment, numb_segments)
%%
%This functions segments a given data string so it generates sets of
%training data
%Is used mostly for testing purposes with a sinusoidal
%%
ndp = length(data); %Get size of data
if size_segment >= ndp
    msg = 'Size of desired segments is larger or equal than the datastream';
    error(msg)
end
r_idx = randi([1 ndp-size_segment],1,numb_segments);
out_data = [];
for idx = r_idx
    out_data = [out_data;data(idx:idx+size_segment-1)];
end
[seq, dtp] = size(out_data);
out_data = reshape(out_data, 1, dtp, seq);

end