function out = fcs_plate_stats(plate)
% FCS_PLATE_DISPLAY_SCATTER plots the histograms of all wells in a plate
out = zeros(96,2);
for i=1:96
out(i,1) = median(log10(plate(i).DATA(:,3)./(plate(i).DATA(:,2)+1)));
out(i,2) = std(log10(plate(i).DATA(:,3)./(plate(i).DATA(:,2)+1)));
end