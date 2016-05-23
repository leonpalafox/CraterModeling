function file_cell = get_csv_files(directory)
files = dir(directory);
file_cell = {};
for file_idx = 1:length(files)
    [pathstr,name,ext] = fileparts(files(file_idx).name);
    if strcmp(ext, '.csv')
        file_cell{end+1} = files(file_idx).name; 
    end
end