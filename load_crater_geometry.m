function crater_geo = load_crater_geometry(crater_filename)
    %first we load the csv file
     crater_geo = csvread(crater_filename);
     crater_geo = imresize(crater_geo, 5);
end