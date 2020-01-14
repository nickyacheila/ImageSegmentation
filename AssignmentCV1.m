
tic;
A=imread('pic1.jpg');
[new_im, labels, means] = imSegment(A, 7, 3);

imshow(new_im);
toc;
