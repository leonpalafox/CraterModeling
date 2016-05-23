function  crater_dataset = read_Crater_dataset(filename)

[num_rows, num_cols] = get_num_lines(filename);
fid = fopen(filename,'r'); 
raw_data = zeros(num_rows, num_cols);
row_idx = 1;
tline = fgetl(fid);
splitString = strsplit(tline,' ');
splitString(1) = [];
splitString=cellfun(@str2num,splitString);
raw_data(row_idx,:) = splitString;
while ischar(tline)
    row_idx = row_idx + 1;
    tline = fgetl(fid);
    if tline~=-1
        splitString = strsplit(tline,' ');
        splitString(1) = [];
        splitString=cellfun(@str2num,splitString);
        raw_data(row_idx,:) = splitString;
    end
end
fclose(fid);
vims_labels = raw_data(:, col_to_show);