%This libary does the profiling for a given crater
%load('DTEEC_002118_1510_003608_1510_A01_200_pixels.mat') %Here we load the mat file that we saved using python
main_path = 'C:\Users\leon\Documents\Data\DTMimages';
filename = 'DTEEC_041277_2115_040776_2115_A01';
load(fullfile(main_path, filename,'.mat'))
mkdir(fullfile(main_path, filename));
save_path = fullfile(main_path, filename);
small_im = a;
%after loading there is a variable called a which ahs all the information
%form the image
%small_im = imresize(small_im, 1/5);%we just make the image smalle to increase speed
pts = readPoints(small_im); %Get the points for each circle, they have to be consecutive points and a multiple of 3
pts = pts';%transpose so it makes sense
symbols = ['a':'z' 'A':'Z'];
MAX_ST_LENGTH = 10;

if ~mod(size(pts,1),3) %check that it was a multiple of three, so all of them are circles
    num_circles = size(pts,1)/3;
    circ_center_array = zeros(num_circles, 2);
    circ_radious_array = zeros(num_circles, 1);
    for pt_idx = 1:num_circles %go over all the sets of each three points
        circle_points = pts(pt_idx*3-2:pt_idx*3,:);
        [c, r] = calcCircle(circle_points(1,:), circle_points(2,:), circle_points(3, :));
        circ_center_array(pt_idx,:) = c;
        circ_radious_array(pt_idx) = r;
        rectangle('Position',[c(1)-r,c(2)-r,2*r,2*r],'Curvature',[1,1],'EdgeColor','g')
        hold on
        plot(c(1), c(2), 'o')
    end
else
    disp 'You did not click three point per crater, please repeat the process'
end
angle_step = 0.1;
C = zeros(size(0:angle_step:2*pi));
%%

r = 1*r; %Increase the crater size by 20%
crater = struct();
hold on
for circ_idx = 1:num_circles
    r = circ_radious_array(circ_idx);
    c = circ_center_array(circ_idx,:);
    c_idx = 1;
    C = [];
    tic
    for r_val = 0:angle_step:2*pi
        [X,Y] = pol2cart(r_val,r); %This transform polar coordinates to cartesians to do the improfile
        X_end = X+c(1);
        X_start = -X + c(1);
        Y_end = Y+c(2);
        Y_start = -Y + c(2);
        x = [X_start X_end];
        y = [Y_start Y_end];
        C_ = improfile(small_im,x,y);
        if c_idx == 1 %For the first iteration don't do anything
            C = [C;C_'];
        end
        if size(C_,1)>size(C,2) %if the current output is larger
            C_ = C_(1:size(C,2),1);
            C = [C;C_'];
        elseif size(C_, 1)<size(C,2) %if the current output is larger
            C = C(:,1:size(C_, 1));
            C = [C;C_'];
        else
            C = [C;C_'];
        end
        c_idx = c_idx +1; 
    end
    crater(circ_idx).center = c;
    crater(circ_idx).radious = r;
    crater(circ_idx).samples = C;
    %generate a random id to tie craters samples and its csv entry
    numRands = length(s);
    stLength = randi(MAX_ST_LENGTH);
    nums = randi(numel(symbols),[1 stLength]);
    crater(circ_idx).crater_id = symbols(nums);
    savefile = fullfile(savepath,crater(circ_idx).crater_id,'.mat');
    save()
    toc
end
%first we save the samples per crater

break
%%
%plot the profile curve and 85% error rates
main_line = mean(C); %take the mean
n = size(C,1);
SEM = std(C)/sqrt(n); 
ts = tinv([0.025  0.975],n-1);
CI_neg = main_line + ts(1)*SEM;
CI_pos = main_line + ts(2)*SEM;
x_data = 1:1:size(C,2);
figure(2)
hold on
X = [x_data fliplr(x_data)];
Y = [CI_neg fliplr(CI_pos)];
h = fill(X, Y, 'k');
set(h,'facealpha',.3)
plot(x_data, main_line, 'k','LineWidth', 4)
xlim([0 max(x_data)])
%plot(x_data, CI_pos, 'r')
%imshow(a)improfile(I,x,y),grid on;
