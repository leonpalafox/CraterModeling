%This file loads the geological map of mars, loads two coordinates take
%the sample and paint a circle of that color
close all
clear
geomap_filename = 'C:\Users\leon\Documents\Data\mars_geo_map\geology.jpg';
crater_filename = 'C:\Users\leon\Dropbox\Code\Octave\CraterModeling\out\WriteText_generatedCrater.csv';
geo_map = imread(geomap_filename);

%after loading the image, we take a sample
upp_limitx = size(geo_map,2)-100;
upp_limity = size(geo_map,1)-100;
low_limit = 100;
num_samples = 4;
figure(1)
imshow(geo_map)
crater_geo = load_crater_geometry(crater_filename); 

break
for sample_idx = 1:num_samples
    figure(1)
    %a + (b-a).*rand(N,1).
    x_coord = round(low_limit+(upp_limitx-low_limit)*rand(1));
    y_coord = round(low_limit+(upp_limity-low_limit)*rand(1));
    text(x_coord+70,y_coord+70, ['Sample ' num2str(sample_idx)], 'FontSize', 15, 'FontWEight', 'Bold')
    
    line_x = [x_coord x_coord]; %vertical
    line_y = [y_coord-50 y_coord+50]; %vertical
    line(line_x, line_y, 'Color', 'red')
    line_x = [x_coord-50 x_coord+50]; %horizonal
    line_y = [y_coord y_coord]; %horizontal
    line(line_x, line_y, 'Color', 'red')
    rectangle('Position',[x_coord-50,y_coord-50,100,100], 'LineWidth',2.5)
%Get the terrain under the coordinates\
    figure(2)
    subplot(1,4,sample_idx)
    color_rgb = squeeze(geo_map(y_coord, x_coord,:));
    %surf(peaks(100), 'EdgeColor','none')
    surface(crater_geo, 'EdgeColor', 'none')
    view(14,53)
    camlight('righ')
    material dull
    title(['Crater with surface sample ', num2str(sample_idx)], 'FontSize', 21)
    colormap(double(color_rgb)'/255)
    axis off
    freezeColors
end


 