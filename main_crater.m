%This libary does the profiling for a given crater
%load('DTEEC_002118_1510_003608_1510_A01_200_pixels.mat') %Here we load the mat file that we saved using python
load('C:\Users\leon\Documents\Data/DTMimages/big_Crater.mat')
small_im = a;
%after loading there is a variable called a which ahs all the information
%form the image
small_im = imresize(small_im, 5);
pts = readPoints(small_im, 3); %Get the three points for the circle
pts = pts';%transpose so it makes sense
[c r] = calcCircle(pts(1,:),pts(2,:), pts(3, :));
rectangle('Position',[c(1)-r,c(2)-r,2*r,2*r],'Curvature',[1,1],'EdgeColor','g')
angle_step = 0.1;
C = zeros(size(0:angle_step:2*pi));
%%
break
r = 1*r; %Increase the crater size by 20%
c_idx = 1;
C = [];
for r_val = 0:angle_step:2*pi
    [X,Y] = pol2cart(r_val,r); %This transform polar coordinates to cartesians to do the improfile
    X = X+c(1);
    Y = Y+c(2);
    x = [c(1) X];
    y = [c(2) Y];
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
