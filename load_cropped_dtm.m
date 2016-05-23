%This library loads the matfiles and saves them as a tiff
path = 'C:\Users\leon\Documents\Data\UGGIData\dtm_hitmaps\DTEEC_027158_2305_026446_2305_A01';
files_cell = get_files(path, '.mat');
num_figures = length(files_cell);
for cell_idx = 1:num_figures
    working_file = fullfile(path, files_cell{cell_idx});
    load(working_file)
    small_im = imresize(small_im, 4);
    [filepath, filename, ext] = fileparts(working_file);
    plot_image_tiff(small_im, fullfile(filepath, filename))
end
% %%
% small_im = small_im(140:end, 140:end);
% vect = [];
% x = []
% y = []
% z = []
% %calculate the plane
% for i = 1:size(small_im,2) %x
%     for j = 1:size(small_im, 1) %y
%         vect(end+1,:) = [i, j, small_im(i,j)];
%         x(end+1) = i;
%         y(end+1) = j;
%         z(end+1) = small_im(i, j);
%     end
% end
% %%
% n = length(x);
% coeff=[ones(n,1) x' y' x'.^2 y'.^2 x'.*y']\z;
% cm = mean(XYZ,1);
% 
% XYZ = vect;
% 
% % subtract off the column means
% XYZ0 = bsxfun(@minus,XYZ,cm);
% 
% % The "regression" as a planar fit is now accomplished by SVD.
% % This presumes errors in all three variables. In fact, it makes
% % presumptions that the noise variance is the same for all the
% % variables. Be very careful, as this fact is built into the model.
% % If your goal is merely to fit z(x,y), where x and y were known
% % and only z had errors in it, then this is the wrong way
% % to do the fit.
% [U,S,V] = svd(XYZ0,0);
% 
% % The singular values are ordered in decreasing order for svd.
% % The vector corresponding to the zero singular value tells us
% % the direction of the normal vector to the plane. Note that if
% % your data actually fell on a straight line, this will be a problem
% % as then there are two vectors normal to your data, so no plane fit.
% % LOOK at the values on the diagonal of S. If the last one is NOT
% % essentially small compared to the others, then you have a problem
% % here. (If it is numerically zero, then the points fell exactly in
% % a plane, with no noise.)
% diag(S)
% 
% % Assuming that S(3,3) was small compared to S(1,1), AND that S(2,2)
% % is significantly larger than S(3,3), then we are ok to proceed.
% % See that if the second and third singular values are roughly equal,
% % this would indicate a points on a line, not a plane.
% % You do need to check these numbers, as they will be indicative of a
% % potential problem.
% % Finally, the magnitude of S(3,3) would be a measure of the noise
% % in your regression. It is a measure of the deviations from your
% % fitted plane.
% 
% % The normal vector is given by the third singular vector, so the
% % third (well, last in general) column of V. I'll call the normal
% % vector P to be consistent with the question notation.
% P = V(:,3);
% 
% % The equation of the plane for ANY point on the plane [x,y,z]
% % is given by
% %
% %    dot(P,[x,y,z] - cm) == 0
% %
% % Essentially this means we subtract off the column mean from our
% % point, and then take the dot product with the normal vector. That
% % must yield zero for a point on the plane. We can also think of it
% % in a different way, that if a point were to lie OFF the plane,
% % then this dot product would see some projection along the normal
% % vector.
% %
% % So if your goal is now to predict Z, as a function of X and Y,
% % we simply expand that dot product.
% % 
% %   dot(P,[x,y,z]) - dot(P,cm) = 0
% %
% %   P(1)*X + P(2)*Y + P(3)*Z - dot(P,cm) = 0
% %
% % or simply (assuming P(3), the coefficient of Z) is not zero...