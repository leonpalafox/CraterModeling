%Load crater database
filename = 'C:\Users\leon\Documents\Data\RobbinsCraterDatabase_20121016.tab\crater_database.csv';
geomap_filename = 'C:\Users\leon\Documents\Data\mars_geo_map\geology.jpg';
geo_map = imread(geomap_filename);
dataset = csvread(filename, 1, 0);
[geo_row, geo_col, ~] = size(geo_map);
figure(1)
imshow(geo_map)
hold on
dummy_dataset = dataset(dataset(:,5)>5,:);
for crater_idx = 1:size(dummy_dataset,1)
    y = dummy_dataset(crater_idx, 1); 
    x = dummy_dataset(crater_idx, 2);
    diam = dummy_dataset(crater_idx, 5);
    y_coord = round((-geo_row/180)*y + geo_row/2);
    x_coord = round((geo_col/360)*x + geo_col/2);
    figure(1)
    line_x = [x_coord x_coord]; %vertical
    line_y = [y_coord-50 y_coord+50]; %vertical
    line(line_x, line_y, 'Color', 'red')
    line_x = [x_coord-50 x_coord+50]; %horizonal
    line_y = [y_coord y_coord]; %horizontal
    line(line_x, line_y, 'Color', 'red')
    rectangle('Position',[x_coord-50,y_coord-50,100,100], 'LineWidth',2.5)
end

