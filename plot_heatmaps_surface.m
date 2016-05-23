%script to read csv values and do the plots of the heatmaps
% 
% a = DTEEC_001521_2025_001719_2025_U01_200_pixels
% b = DTEEC_027158_2305_026446_2305_A01_200_pixels
% c = DTEEC_023531_1840_023953_1840_A01_200_pixels
% d = DTEEC_002118_1510_003608_1510_A01_200_pixels
% e = DTEEC_026076_2320_026419_2320_A01_200_pixels
%%
close all
directory = 'C:\Users\leon\Documents\Data\UGGIData\dtm_hitmaps\DTEEC_027158_2305_026446_2305_A01'; %This is a relative path
csv_cell = get_csv_files(directory);
num_figures = length(csv_cell);
for fig_idx = 1:num_figures
    figure(fig_idx)
    M = csvread(fullfile(directory, csv_cell{fig_idx}));
    limit = 4;
    M(:,end-limit:end)=[];
    M(:,1:limit) = [];
    M(1:limit,:) = [];
    M(end-limit:end,:) = [];
    h = fspecial('gaussian', 2, 2);
    %M = imresize(M, 6133/178);
    filteredRGB = imfilter(M, h);
    surface((2*mat2gray(filteredRGB(1+limit:end-limit,1+limit:end-limit))-1), 'EdgeColor', 'none')
    %caxis([0,1])
    colormap jet
    axis off
    axis equal
    h=colorbar;
    set(h,'fontsize',18);
    %view(-188,-28)
    view(90,90) %So it looks like a map
    [path, name] = fileparts(fullfile(directory,csv_cell{fig_idx}));
    filename =  [name, '_heatmap', '.png'];
    saveas(gcf,fullfile(path, filename))
end