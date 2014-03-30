%%
% Old Media
[plate,plate_order]= fcs_plate_read('/home/kieran/Desktop/oldMedia/96 Well - U bottom/')
%%
% New Media
[plate,plate_order]= fcs_plate_read('/home/kieran/Desktop/newMedia/96 Well - U bottom/')
%%
for i = 1:96, YFP{i} = plate(i).DATA(:,8) ./ plate(i).DATA(:,5); end
for i = 1:96, YFP_{i} = YFP{i}(YFP{i}>0), end
%%
y = YFP_
%%
figure
ym = cellfun(@mean,y);
ymr = reshape(ym,12,8);
imagesc(log(ymr)')
%%
figure
yv = cellfun(@var,y);
yvr = reshape(yv,12,8)
imagesc(log(yvr)')
%%
figure
ycv2 = yv./(ym.^2);
ycv2r = reshape(ycv2,12,8)
imagesc(log(ycv2r)')
%%
figure
for i = 1:96,
subplot(8,12,i)
[count, centers] = hist(log(y{i}),40);
dist = count/sum(count);
plot(centers, dist)
xlim([-7 3]);
ylim([0 0.4]);
end