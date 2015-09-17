clearvars
fcs_file = 'sic1_aug27/96 Well - U bottom/';
[plate,plate_order] = fcs_plate_read(fcs_file)

%%
for i = 1:96, 
    yfp_corrected{i} = plate(i).DATA(:,8) ./ plate(i).DATA(:,5); 
    yfp_corrected_clean{i} = yfp_corrected{i}(yfp_corrected{i}>0);
end
%%
% Filter
y = yfp_corrected_clean;
%%
% Summary stats
cells_median = @(x) cellfun(@nanmedian,x);
cells_cv2 = @(x) cellfun(@nanvar,x) ./ cellfun(@nanmean,x).^2;
cells_var = @(x) cellfun(@nanvar,x);

y_median = cells_median(y);
y_var = cells_var(y);
y_cv2 = cells_cv2(y); 

%%
reshape_to_plate = @(x) reshape(x,12,8);
y_median = reshape_to_plate(y_median);
y_cv2 = reshape_to_plate(y_cv2);
figure
subplot(1,2,1)
imagesc(log(y_median)')
subplot(1,2,2)
imagesc(log(y_cv2)')