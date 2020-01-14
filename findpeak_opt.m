function [peak,cpts] =  findpeak_opt(data, idx, r) % peak searching process 
%data:n-dimensional dataset consisting of p points
%idx:column index of the data point for which we wish to compute its associated density peak
%r:the search  window radius

    shift=1000; % we initialize a shift threshold 
    cpts=zeros(size(data,2),1);
    current_point=data(:,idx);
    iterations=0;
    while shift>0.3 % when the shift threshold becomes <=0.01 the algorithm stops
%cpts : 1 for each point r/4 in path
        iterations=iterations+1;
        distances = pdist2(data', current_point', 'euclidean'); %all the distances between current point and data 
        in_path = distances<= r/4;
        cpts=cpts+in_path;
        in_sphere = distances<= r; % the indices of the data points that are inside the sphere
        B=data(:,(in_sphere)); %the data points that are inside the sphere
        current_peak=mean(B,2); %the peak of the current sphere
        shift=pdist2(current_point',current_peak','euclidean'); % how far off are we from the next peak
        current_point=current_peak; %set current point as peak
    end
    cpts=cpts>0;
    peak=current_peak; %this is the peak that will be returned
end