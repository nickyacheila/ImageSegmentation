function [new_im, labels, means] = imSegment(im, r, feature_type)
%IMSEGMENT image segmentation

B=rgb2lab(im);
 
if feature_type == 3
    new=B;
elseif feature_type ==5 
    X=zeros(size((B),1),size((B),2)); %for row indices
    Y=zeros(size((B),1),size((B),2)); %for column indices
    for index = 1:size(X,1)
        X(index,:)=index; %fill in
    end
    for index = 1:size(Y,2)  %fill in
        Y(:,index)=index;
    end
    new(:,:,1:3)=B; %create new matrix with row,column info
    new(:,:,4)=X;
    new(:,:,5)=Y;
else
    disp('wrong feature');
    return
end
data_1 = reshape(new(:),[],size(new,3)); %vectorization
data_1=data_1';
data_1=im2double(data_1); %make double for pdist
[labels,means]=meanshift_opt(data_1,r); %segmentation
 means1=zeros(3,size(means,2));
means1(:)=means(1:3,:);
means1=means1';
 e = reshape(means1(:),size(B,1),size(B,2),3);
 e=e(:,:,1:3);
 new_im=lab2rgb(e); %recreate new image

disp(size(unique(labels)));


   
end
