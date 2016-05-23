function [num_rows, num_cols] = get_num_lines(filename)
%This script gets the number of lines of a file
fid = fopen(filename,'r');
tline = fgetl(fid);
splitString = strsplit(tline,'\t');
splitString(1) = [];
num_cols = size(splitString, 2);
num_rows = 0;
while ischar(tline)
    num_rows = num_rows + 1;
    tline = fgetl(fid);
end
fclose(fid);