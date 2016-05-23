%Load crater database
filename = 'C:\Users\leon\Documents\Data\RobbinsCraterDatabase_20121016.tab\crater_database.csv';
geomap_filename = 'C:\Users\leon\Documents\Data\mars_geo_map\geounits.tif';
geo_map = imread(geomap_filename);
dataset = csvread(filename, 1, 0);
[geo_row, geo_col, ~] = size(geo_map);
%figure(1)
%imshow(geo_map)
heatmap_image = zeros(geo_row, geo_col);
dummy_dataset = dataset(dataset(:,5)>10,:);
color_cell = cell(1, size(dummy_dataset, 1));
color_vect = zeros(size(dummy_dataset, 1), 3); %this holds the RGB values
for crater_idx = 1:size(dummy_dataset,1)
    y = dummy_dataset(crater_idx, 1); 
    x = dummy_dataset(crater_idx, 2);
    diam = dummy_dataset(crater_idx, 5);
    y_coord = ceil((-geo_row/180)*y + geo_row/2);
    x_coord = ceil((geo_col/360)*x + geo_col/2);
    %figure(1)
    color_rgb = squeeze(geo_map(y_coord, x_coord,:));
    out = bsxfun(@minus,double(color_vect),double(color_rgb'));
    temp = out.^2;
    temp  =sum(temp, 2);
    temp = sqrt(temp);
    if isempty(temp(temp<60))
        color_vect(crater_idx, :) = color_rgb';
    else
        [vla inda] = min(temp);
        color_vect(crater_idx, :) = color_vect(inda, :);
        color_rgb = color_vect(inda, :)';
    end
    hex_color = rgb2hex(color_rgb');
    heatmap_image(y_coord, x_coord) = heatmap_image(y_coord, x_coord)+1;
    color_cell{crater_idx} = hex_color;
end

unique_colors = unique(color_cell);
p = numSubplots(length(unique_colors));
subplot_idx = 1;
for color_idx = unique_colors
    subplot(p(1),p(2), subplot_idx)
    [n1,x1]=hist(dummy_dataset(strcmp(color_cell, color_idx), 5));
    h = bar(x1, n1);
    set(h,'facecolor',color_vect(subplot_idx, :)/255,'edgecolor','b')
    subplot_idx = subplot_idx + 1;
end

