%script to read csv values and do the plots of the heatmaps
close all
directory = 'out/'; %This is a relative path
csv_cell = get_csv_files(directory);
num_figures = length(csv_cell);
for fig_idx = 15:15
    figure(fig_idx)
    M = csvread([directory, csv_cell{fig_idx}]);
    limit = 10;
    M(:,end-limit:end)=[];
    M(:,1:limit) = [];
    M(1:limit,:) = [];
    M(end-limit:end,:) = [];
    h = fspecial('gaussian', 10, 10);
    filteredRGB = imfilter(M, h);
    surface(2*mat2gray(filteredRGB(1+limit:end-limit,1+limit:end-limit))-1, 'EdgeColor', 'none')
    caxis([0,1])
    colormap jet
    axis off
    view(180,-90) %So it looks like a map
    filename =  [csv_cell{fig_idx}, '.png'];
    saveas(gcf,filename)
end