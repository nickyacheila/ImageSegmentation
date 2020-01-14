function [labels, peaks] = meanshift(data,r) 
%calls findpeak for each point and then assigns a label to each point according to its peak
label_count=0; %points the label
labels=zeros(1,size(data,2)); %vector of each datapoint's label
peaks_for_elements=-1000*ones(size(data,1),size(data,2));%vector of each datapoint's calculated peak
iterations=0;
    for index=1:size(data,2)
        if labels(1,index)==0
            iterations=iterations+1;
            current_peak=findpeak_opt(data,index,r);
            % First Speed-up Basin of attraction
            distances_data_peak=pdist2(data', current_peak', 'euclidean'); %this is for basin
            in_basin=distances_data_peak<=r; %find datapoints inside basin
            distances_peaks_to_current_peak = pdist2(peaks_for_elements', current_peak', 'euclidean'); %this is for peak associastion
            same_peaks=distances_peaks_to_current_peak<= r/2; %boolean vector 0:not same peaks 1:same peaks
            if size(same_peaks(same_peaks~=0),1)==0 %if there are no same peaks
                label_count=label_count+1; %increament label index
                labels(1,in_basin)=label_count; %add the new label to the labels vector
            else  %if there is already one peak <=r/2 close to the current peak
                last_index = find(same_peaks,1);                 
                current_peak=peaks_for_elements(:,last_index);
                labels(1,in_basin)=labels(:,last_index);
                labels(1,index)=labels(:,last_index); %assign to the current point cause it might not be in the basin
                peaks_for_elements(:,index)=current_peak; %assign to the current point cause it might not be in the basin

            end
            
            peaks_for_elements(:,in_basin)=repmat(current_peak,1,size( peaks_for_elements(:,in_basin),2)); %assign which peak corresponds to the current element 
        end
        
    end

peaks = peaks_for_elements; %make the output peak with the unique peaks
% disp(iterations);
end