%This libary does the profiling for a given crater
load('C:\Users\leon\Documents\Data\DTMimages\big_Crater.mat') %Here we load the mat file that we saved using python
%after loading there is a variable called a which ahs all the information
%form the image
pts = readPoints(a, 2); %Get the three points for the circle
%pts = pts';%transpose so it makes sense
cropped_crater = a(pts(2,1):pts(2,2), pts(1,1):pts(1,2));
[row, col] = size(cropped_crater);
cropped_crater = cropped_crater(1:min(col,row),1:min(col,row));
%%
small_im = imresize(cropped_crater, 200/min(col,row));
%imshow(a)improfile(I,x,y),grid on;
