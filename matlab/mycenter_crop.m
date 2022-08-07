function img = center_crop(img, cropx, cropy)
[y, x, ~] = size(img);
startx = fix(x/2)-fix(cropx/2);
starty = fix(y/2)-fix(cropy/2);
img = img(starty+1:starty+cropy, startx+1:startx+cropx, :);
end

