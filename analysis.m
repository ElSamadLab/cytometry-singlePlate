
clearvars
doses = 250./2.^(11:-1:0);
[plate_p1,plate_order_p1] = fcs_plate_read('/home/kieran/Desktop/AA/140330_mixforlater_e2_p4_250_down_p1/96 Well - U bottom/')

[plate_p2,plate_order_p2] = fcs_plate_read('/home/kieran/Desktop/AA/140330_mixforlater_e2_p4_250_down_p2/96 Well - U bottom/')
%%
for i = 1:24, YFP_P1{i} = plate_p1(i).DATA(:,8) ./ plate_p1(i).DATA(:,5); end
for i = 1:24, YFP_P1_CLEAN{i} = YFP_P1{i}(YFP_P1{i}>0); end

for i = 1:24, YFP_P2{i} = plate_p2(i).DATA(:,8) ./ plate_p2(i).DATA(:,5); end
for i = 1:24, YFP_P2_CLEAN{i} = YFP_P2{i}(YFP_P2{i}>0); end

%%
% [a index] = sort(plate_order_p1);
% YFP_P1 = YFP_P1(index);
% YFP_P1_CLEAN = YFP_P1_CLEAN(index);
% [a index] = sort(plate_order_p2);
% YFP_P2 = YFP_P2(index);
% YFP_P2_CLEAN = YFP_P2_CLEAN(index);

y1 = YFP_P1_CLEAN;
y2 = YFP_P2_CLEAN;
%%
figure
ym1 = cellfun(@nanmedian,y1);
ymr = reshape(ym1,12,2);
subplot(211)
semilogx(doses, ymr)
title('linear')
legend('Estradiol','Progesterone', 'location', 'northwest')
subplot(212)
semilogx(doses, log10(ymr))
title('log')
legend('Estradiol','Progesterone', 'location', 'northwest')
%%
figure
ym1 = cellfun(@nanmedian,y2);
ymr = reshape(ym1,12,2);
subplot(211)
semilogx(doses, ymr)
title('linear')
legend('Estradiol','Progesterone', 'location', 'northwest')
subplot(212)
semilogx(doses, log10(ymr))
title('log')
legend('Estradiol','Progesterone', 'location', 'northwest')